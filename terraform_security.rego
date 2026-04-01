package terraform.authz

import future.keywords.if

default allow = {
    "status": false,
    "reason": "El recurso no cumple con los requisitos de la política."
}

allow = result if {
    # Buscamos cambios en recursos de tipo security group
    some i
    resource := input.resource_changes[i]
    resource.type == "aws_security_group"
    
    # Accedemos a los bloques ingress (que vienen como lista en el 'after')
    some j
    ingress := resource.change.after.ingress[j]
    
    # Validamos que la IP esté dentro de la lista de cidr_blocks
    # Usamos [_] para verificar si el valor existe en esa lista
    ingress.cidr_blocks[_] == "152.230.70.226/32"
    
    result := {
        "status": true,
        "reason": "El recurso cumple con la política: IP de SSH autorizada."
    }
}