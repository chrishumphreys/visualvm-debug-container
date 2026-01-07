# Heap analysis of java processes within k8s

Uses VisualVM along with X11VNC and noVNC to provide web based VisualVM within k8s cluser as a sidecar for the application you wish to inspect.

Example k8s manifest provided to demonstrate how to deploy to inspect another container's heap.

# Build the image
docker build -t visualvm-web:latest .

# Deploy the pod
kubectl apply -f pod.yaml

# Access
Once running, you can port-forward to access the interface:

kubectl port-forward java-debug-pod 6080:6080
