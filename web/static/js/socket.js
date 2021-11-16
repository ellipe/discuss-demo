import { Socket } from 'phoenix'
let socket = new Socket('/socket', { params: { token: window.userToken } })

socket.connect()

// Now that you are connected, you can join channels with a topic:

const createSocket = topicId => {
  let channel = socket.channel(`comments:${topicId}`, {})
  channel
    .join()
    .receive('ok', resp => {
      renderComments(resp.comments)
    })
    .receive('error', resp => {
      console.log('Unable to join', resp)
    })

  channel.on(`comments:${topicId}:new`, ({ comment }) => {
    renderComment(comment)
  })

  document.querySelector('button').addEventListener('click', function () {
    const content = document.querySelector('textarea').value
    channel.push('comments:add', { content: content })
    clearCommentInput()
  })
}

const commentTemplate = comment => {
  let email = 'Anonymous'

  if (comment.user) {
    email = comment.user.email
  }
  return `<li class="collection-item"> ${comment.content}
    <div class="secondary-content"> ${email} </div>
  </li>`
}

const renderComment = comment => {
  const renderedComment = commentTemplate(comment)

  document.querySelector('.collection').innerHTML += renderedComment
}

const clearCommentInput = () => {
  document.querySelector('.materialize-textarea').value = ''
}

const renderComments = comments => {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment)
  })

  document.querySelector('.collection').innerHTML = renderedComments.join('')
}

window.createSocket = createSocket
