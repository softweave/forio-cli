exec  = (require 'child_process').exec

uploadFile = (localPath, simPath, user, password, callback)->
    list = localPath.split('/')
    folder = if list.length > 1 then list[0..(list.length - 2)].join('/') else ''

    exec "#{__dirname}/../../../upload.sh #{localPath} #{simPath} #{user} #{password}", callback

uploadFileAPI = (domain, localPath, simPath, token, callback)->
    file_url = "#{domain}/simulate/api/file/#{simPath}"
    exec "curl --silent -L -F token=#{token} -F content=@#{localPath} -F method=PUT #{file_url}", callback

uploadZip = (domain, localPath, simPath, token, callback)->
    file_url = "#{domain}/simulate/api/file/#{simPath}"
    exec "curl -L -F token=#{token} -F content=@#{localPath} -F method=PUT -F unzip=true #{file_url}", callback

exports.uploadFile = uploadFile
exports.uploadFileAPI = uploadFileAPI
exports.uploadZip = uploadZip
