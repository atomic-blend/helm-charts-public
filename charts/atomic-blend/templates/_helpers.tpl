{{/*
Expand the name of the chart.
*/}}
{{- define "atomic-blend-component.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "atomic-blend-component.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .serviceName }}
{{- .serviceName | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .serviceName $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a service-specific fully qualified app name.
*/}}
{{- define "atomic-blend-component.servicename" -}}
{{- .serviceName | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "atomic-blend-component.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "atomic-blend-component.labels" -}}
helm.sh/chart: {{ include "atomic-blend-component.chart" . }}
{{ include "atomic-blend-component.selectorLabels" . }}
{{- if .serviceName }}
app.kubernetes.io/version: {{ (index .Values.manifest .serviceName).version | default .Chart.AppVersion | quote }}
{{- else }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "atomic-blend-component.selectorLabels" -}}
app.kubernetes.io/name: {{ include "atomic-blend-component.name" . }}
{{- if .serviceName }}
app.kubernetes.io/instance: {{ .serviceName }}
{{- else }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- end }}
