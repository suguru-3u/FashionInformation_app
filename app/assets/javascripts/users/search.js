$(document).on('turbolinks:load', function(){
  const inputForm = $('#search-input');
  const searchResult = $('.result ul');

// データがあった場合に呼ばれる関数
  function builtHTML(data){
    let html = `
    <li>${data.title}</li>
    `
    searchResult.append(html);
  }
// 該当するデータがなかった時に呼ばれる関数
  function NoResult(message){
    let html = `
    <li>${message}</li>
    `
    searchResult.append(html);
  }

  // フォームに入力すると発火する
  inputForm.on('keyup', function(){
    const target = $(this).val();
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
    })
  }
});
