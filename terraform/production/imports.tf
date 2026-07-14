# The servers exist already (bought manually); adopt them into state instead
# of creating them. Harmless after the first apply — an already-managed
# resource is skipped.
import {
  for_each = var.nodes
  to       = module.cluster.hcloud_server.node[each.key]
  id       = tostring(each.value.server_id)
}
