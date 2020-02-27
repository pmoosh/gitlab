{{- if .Values.rbac.create }}
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: {{ template "gitlab.fullname" . }}-permissive-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: {{ template "gitlab.fullname" . }}-cluster-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: admin
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: kubelet
- apiGroup: rbac.authorization.k8s.io
  kind: Group
  name: system:serviceaccounts
labels:
  heritage: {{ .Release.Service | quote }}
  release: {{ .Release.Name | quote }}
  chart: {{ template "gitlab.chart" . }}
  app: {{ template "gitlab.name" . }}


apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
    rbac.authorization.k8s.io/aggregate-to-edit: "true"
  name: {{ template "gitlab.fullname" . }}-cluster-admin
rules:
- apiGroups:
  - rbac.authorization.k8s.io
  resources:
  - rolebindings
  - roles
  verbs:
  - create
  - delete
  - deletecollection
  - get
  - list
  - patch
  - update
  - watch


{{- end }}
