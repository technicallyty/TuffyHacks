<script>
	import {ethers} from "ethers";
	import * as abi1 from './data/Election.json';
	let candidates = [];
	let results = [];
	let selected = "";
	let provider;
	let signer;
	let contract;

	const connect = async () => {
		await window.ethereum.enable()
		provider = new ethers.providers.Web3Provider(window.ethereum);
		signer = provider.getSigner();
		contract = new ethers.Contract("0x5fbdb2315678afecb367f032d93f642f64180aa3", abi1.abi, signer);
		let allCandidates = await contract.getCandidates();
		let allC = [];
		for(let c of allCandidates) {
			allC.push(c.name);
		}
		candidates = allC;
	}

	const vote = async () => {
		let id = candidates.indexOf(selected);
		console.log(id);
		let receipt = await contract.vote(id);
	}

	const showResults = async () => {
		let localresults = [];
		for(let i = 0; i < candidates.length; i++) {
			let result = {};
			let name = candidates[i];
			let votes = await contract.checkVotes(i);
			votes = votes.toNumber();
			
			result["name"] = name;
			result["votes"] = votes;
			localresults.push(result);
		}
		results = localresults;
	}

</script>

<main>
	<h1>Election on the Blockchain</h1>
	<button on:click={connect}>
		connect to metamask
	</button>
	<select bind:value={selected}>
		{#each candidates as name}
			<option value={name}>
				{name}
			</option>
		{/each}
	</select>
	<button on:click={vote}>
		Send Vote!
	</button>
	<button on:click={showResults}>
		Show Results
	</button>
	{#each results as result}
		<container>
			<h4>Name: {result.name}   Votes: {result.votes}</h4>
		</container>
	{/each}
</main>




<style>

	container {
		display: flex;
		flex-direction: row;
		margin: 0px 50px;
	}

	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
	}

	h1 {
		color: #ff3e00;
		text-transform: uppercase;
		font-size: 4em;
		font-weight: 100;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>