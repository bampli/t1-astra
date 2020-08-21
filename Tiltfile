# Run scripts/setup.sh to launch cluster

k8s_yaml('./configMap.yaml')

k8s_yaml('./kube/06-backend.yaml')

#k8s_kind('Environment', image_json_path='{.spec.runtime.image}')

docker_build('astra-backend', './server',
    live_update=[
        sync('./server', '/usr/src/app'),
        run('cd /usr/src/app && pip install -r requirements.txt',
            trigger='./server/requirements.txt')
])

k8s_resource('astra-backend', port_forwards=[
    9999,  # app
    5678,  # debugger
])

# k8s_yaml('./web/kubernetes.yaml')

# docker_build('nginx-image', './web',
#     live_update=[
#         sync('./web/nginx.conf', '/etc/nginx/nginx.conf'),
#         sync('./web/index.html', '/usr/share/nginx/html/index.html')
# ])

# k8s_resource('nginx',
#             port_forwards=[
#                         80,  # app
#             ])
