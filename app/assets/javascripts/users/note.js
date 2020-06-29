$(document).on('turbolinks:load', function(){
  function buildHTML(note) {
    var html = `<div class="row">
      <div class="col-4 mb-5">
        <div class="card">
          <img class="attachment post post_image card-img-top" src="${note.post_image_id}">
           <div class="card-body">
            ${note.title}
            <p class = 'class='card-text''>
              <a href="/users/notes/${note.id}/edit">詳細</a>
              <a rel="nofollow" data-method="delete" href="/users/notes/${note.id}">削除</a>
            </p>
           </div>
        </div>
      </div>
    </div>`
  return html;
  }
  $('.note_submit').on('submit', function(e){
    e.preventDefault();
    var note = new FormData(this); //フォームに入力した値を取得しています。
    $.ajax({
      url: '/users/notes',
      type: 'POST',
      data: note,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(post){
      var html = buildHTML(note);
      $('#note_card').append(html);
      $('#note_title').val(''); //input内のメッセージを消しています。
      $('#note_image').val(''); //input内のメッセージを消しています。
      $('#note_body').val(''); //input内のメッセージを消しています。
    })
    .fail(function(post){
      alert('エラーが発生したためメッセージは送信できませんでした。');
    })
    .always(function(data){
      $('.note_submit').prop('disabled', false);//ここで解除している
    })
  })
});
