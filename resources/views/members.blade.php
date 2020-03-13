<!DOCTYPE html>
<html lang="ja">

<head>
  <meta charset="UTF-8">
  <title>名簿</title>
  <style>
    table {
      border-collapse: collapse;
    }

    tr {
      page-break-inside: avoid;
    }

    th,
    td {
      border: 1px solid black;
    }
  </style>
</head>

<body>
  <h1>名簿</h1>
  <table>
    <tr>
      <th>No.</th>
      <th>氏名</th>
      <th>住所</th>
      <th>電話番号</th>
      <th>備考</th>
      @for ($no = 1; $no <= 50; $no++) <tr>
        <td>{{ $no }}</td>
        <td style="white-space: nowrap">{{ $member->name }}</td>
        <td>{{ $member->address }}</td>
        <td>{{ $member->phoneNumber }}</td>
        <td>{{ $member->realText }}</td>
    </tr>
    @endfor
  </table>
</body>

</html>