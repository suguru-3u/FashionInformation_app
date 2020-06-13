$(document).on('turbolinks:load', function(){
  var inputForm = $('#search-input');
  var searchResult = $('.result ul');

// データがあった場合に呼ばれる関数
  function builtHTML(data){
    var html = `
    <li>${data.title}</li>
    `
    searchResult.append(html);
  }
// 該当するデータがなかった時に呼ばれる関数
  function NoResult(message){
    var html = `
    <li>${message}</li>
    `
    searchResult.append(html);
  }

  // フォームに入力すると発火する
  inputForm.on('keyup', function(){
    var target = $(this).val();
    search(target);
    console.log(target)
  });

  // ajax処理
  function search(target){
    $.ajax({
      type: 'GET',
      url: '/users/users/posts',
      data: {name: target},
      dataType: 'json'
    })
    // データを受け取れた際の処理
    .done(function(data){
      searchResult.empty(); //再度検索した際に前のデータを消す処理
      if (data.length !== 0) {
        data.forEach(function(data) { //dataは配列型に格納されているのでEach文で回す
          builtHTML(data)
        });
      } else {
        NoResult('該当するタイトルはありません')
      }
    })
    // データを受け取れなかった際の処理
    .fail(function(data){
      alert('非同期通信に失敗しました');
    })git clone https://github.com/suguru-3u/FashionInformation_app.git
  }
});
