# Upgrade the Control Plane

- Upgrade kubeadm:

[cloud_user@k8s-control]$ sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubeadm=1.21.1-00

- Make sure it upgraded correctly:

[cloud_user@k8s-control]$ kubeadm version

- Drain the control plane node:

[cloud_user@k8s-control]$ kubectl drain k8s-control --ignore-daemonsets

- Plan the upgrade:

[cloud_user@k8s-control]$ sudo kubeadm upgrade plan v1.21.1

- Upgrade the control plane components:

[cloud_user@k8s-control]$ sudo kubeadm upgrade apply v1.21.1

- Upgrade kubelet and kubectl on the control plane node:

[cloud_user@k8s-control]$ sudo apt-get update && \
sudo apt-get install -y --allow-change-held-packages kubelet=1.21.1-00 kubectl=1.21.1-00

- Restart kubelet:

[cloud_user@k8s-control]$ sudo systemctl daemon-reload

[cloud_user@k8s-control]$ sudo systemctl restart kubelet

- Uncordon the control plane node:

[cloud_user@k8s-control]$ kubectl uncordon k8s-control

- Verify the control plane is working:

[cloud_user@k8s-control]$ kubectl get nodes

If it shows a NotReady status, run the command again after a minute or so. It should become Ready.


# Upgrade the Worker Nodes

    Note: In a real-world scenario, you should not perform upgrades on all worker nodes at the same time. Make sure enough nodes are available at any given time to provide uninterrupted service.

## Worker Node

    Run the following on the control plane node to drain worker node 1:

    [cloud_user@k8s-control]$ kubectl drain k8s-worker1 --ignore-daemonsets --force

    You may get an error message that certain pods couldn't be deleted, which is fine.

    In a new terminal window, log in to worker node 1:

    ssh cloud_user@<WORKER_1_PUBLIC_IP_ADDRESS>

    Upgrade kubeadm on worker node 1:

    [cloud_user@k8s-worker1]$ sudo apt-get update && \
    sudo apt-get install -y --allow-change-held-packages kubeadm=1.21.1-00

    [cloud_user@k8s-worker1]$ kubeadm version

    Back on worker node 1, upgrade the kubelet configuration on the worker node:

    [cloud_user@k8s-worker1]$ sudo kubeadm upgrade node

    Upgrade kubelet and kubectl on worker node 1:

    [cloud_user@k8s-worker1]$ sudo apt-get update && \
    sudo apt-get install -y --allow-change-held-packages kubelet=1.21.1-00 kubectl=1.21.1-00

    Restart kubelet:

    [cloud_user@k8s-worker1]$ sudo systemctl daemon-reload

    [cloud_user@k8s-worker1]$ sudo systemctl restart kubelet

    From the control plane node, uncordon worker node 1:

    [cloud_user@k8s-control]$ kubectl uncordon k8s-worker1