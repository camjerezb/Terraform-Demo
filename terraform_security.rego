package terraform.authz

import future.keywords.if

default allow = {
    "status": false,
    "reason": "El recurso no cumple con los requisitos de la política."
}

allow = result if {
    input.resource_changes[_].type == "ingress"
    input.resource_changes[_].change.after.cidr_blocks == "152.230.70.226/32"
    
    result := {
        "status": true,
        "reason": "El recurso cumple con la política y la clave pública es válida."
    }
}