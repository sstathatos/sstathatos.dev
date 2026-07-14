{{- define "site.name" -}}
site
{{- end -}}

{{- define "site.labels" -}}
app.kubernetes.io/name: {{ include "site.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
