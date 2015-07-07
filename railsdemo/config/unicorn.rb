worker_processes 2

APP_ROOT = '/Users/liqi/projects/personal/toy/railsdemo'

working_directory APP_ROOT

stderr_path "#{APP_ROOT}/log/unicorn.stderr.log"
stdout_path "#{APP_ROOT}/log/unicorn.stdout.log"
