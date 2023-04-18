<script>
	import { onMount } from 'svelte';

	let message = 'WebSocket未接続';
	let audioSrc = '';
	let socket;

	onMount(() => {
		// WebSocket URL
		socket = new WebSocket('wss://????????.execute-api.ap-northeast-1.amazonaws.com/production');
		// WebSocketのエラー処理
		socket.onerror = (e) => {
			console.error(e);
		};

		// 接続後、表示する文字列を変更する
		socket.onopen = () => {
			message = 'WebSocket接続中';
		};

		// 画像保存先のS3 URLが送られてくるので、imgタグのsrcをそのURLに変更する
		socket.onmessage = (e) => {
			audioSrc = e.data;
		};
	});

	const formSend = () => {
		socket.send(
			JSON.stringify({
				action: 'send_voice',
				selectedImage: 'zn_sugoinoda'
			})
		);
	};
</script>

<audio autoplay src={audioSrc} />
<button on:click={() => formSend()}>すごいのだ</button>

<div id="box" class="box">
	<p>{message}</p>
</div>

<style>
	.box {
		display: inline-block;
		border: double;
	}

	.box p {
		margin: 1px;
		padding: 1px;
		font-size: 80%;
	}
</style>
