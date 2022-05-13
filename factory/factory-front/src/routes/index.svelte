<script>
$: items = fetch(`${process.env.SERVER_URL}/manufactures`)
                .then(response => response.json())
</script>

<div class="whole">
    <div class="field">
        <h2 class="titleText">강알리 든킨드나쓰 Factory</h2>
    </div>
    <h2 class="factory_process"> 공장 생산 진행상태</h2>
    <table class="productTable">
        <thead class="headTitle">
            <tr>
                <th>PID</th>
                <th>Requester</th>
                <th>code</th>
                <th>msg</th>
                <th>Callback</th>
                <th>action</th>
            </tr>
        </thead>
        
    </table>    
</div>


<style>
.whole {
    @apply grid place-items-center h-40 my-20;
}
.whole .field {
    @apply box-content p-5 border-4 h-80 w-80 content-center;
    @apply flex justify-center items-center; 
    @apply w-4/6 h-5/6; 
    @apply bg-gradient-to-b from-slate-100 via-slate-200 to-slate-300;
}    

.whole .field .titleText {
    @apply font-sans;
    @apply text-2xl;
    @apply text-blue-900
}

.whole .factory_process {
    @apply my-7;
    @apply font-serif text-2xl;
}

.whole .productTable {
    @apply border-separate table-auto w-9/12;
    @apply font-mono;
}

.whole .productTable .headTitle {
    @apply border border-slate-600 bg-slate-500;
    @apply text-slate-100;
}

</style>