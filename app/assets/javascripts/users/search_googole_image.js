// $(function() {
//   $('#btn').on('click', function() {
//
//   var API_KEY = 'ENV['Google_image_search_API']'
//   var Engine_id = 'ENV['Search_ennge_ID']'
//   var snap = 'スナップ'
//   var url = 'https://www.googleapis.com/customsearch/v1?key=API_KEY&cx=Engine_id&searchType=image&snap + $('#cityname').val() + =hawksnow-log';
//
//   $.ajax({
//     url: url,
//     dataType: "json",
//     type: 'GET',
//   })
//
//   .done(function(data) {
//     var cityName = '<h2>' + data.city.name + '</h2>';
//     $('#city-name').html(cityName);
//     //
//     // $('#weather').html(insertHTML);
//   })
//   .fail(function(data) {
//      console.log("検索に失敗しました");
//    });
//   });
// });
