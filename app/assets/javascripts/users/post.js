$(document).on('turbolinks:load', function(){
  function buildHTML(post) {
    var html = `<div class="row">
      <div class="col-4 mb-5">
        <div class="card">
          <img class="attachment post post_image card-img-top" src="${post.post_image_id}">
           <div class="card-body">
            ${post.title}
            <p class = 'class='card-text''>
              <a href="/users/posts/${post.id}">見る</a><br>
              <a rel="nofollow" data-method="post" href="/users/posts/${post.id}/favorites">お気に入り</a>
              <a href="/users/posts/${post.id}/edit">編集</a>
              <a rel="nofollow" data-method="delete" href="/users/posts/${post.id}">削除</a>
            </p>
           </div>
        </div>
      </div>
    </div>`
  return html;
  }
  $('.post_submit').on('submit', function(e){
    e.preventDefault();
    var post = new FormData(this); //フォームに入力した値を取得しています。
    console.log(post);
    $.ajax({
      url: '/users/posts',
      type: 'POST',
      data: post,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(post){
      var html = buildHTML(post);
      $('#post_card').append(html);
      $('#post_title').val(''); //input内のメッセージを消しています。
      $('#post_image').val(''); //input内のメッセージを消しています。
      $('#post_body').val(''); //input内のメッセージを消しています。
    })
    .fail(function(post){
      alert('エラーが発生したためメッセージは送信できませんでした。');
    })
    .always(function(data){
      $('.post_submit').prop('disabled', false);//ここで解除している
    })
  })
});

// postのindexのtabメニューの処理
document.addEventListener("turbolinks:load", function(){
  $('#tab-contents .tab[id != "tab1"]').hide();

  $('#tab-menu-post a').on('click', function() {
    $("#tab-contents .tab").hide();
    $("#tab-menu-post .active").removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
})
