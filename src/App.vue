<script setup lang="ts">
import { ref } from 'vue';
import STable from './components/s-table.vue';  

const items = ref<any[]>([])
const columns = ref<any[]>([
  { field: 'title' },
  {
    field: 'type',
    type: 'select',
    options: ['normal', 'special', 'super-special']
  },
])

for (let i = 0; i < 10; i++) {
  items.value.push({
    title: `item-${i}`,
    type: `normal`,
  })
  
}

interface Payload {
  index: number,
  data: any
}

function update({ index, data }: Payload) {
  const item = items.value[index]

  Object.assign(item, data)
}

</script>

<template>
  <div class="h-screen w-screen flex items-center justify-center">
    <div class="max-w-[80vw] w-full">
      <s-table
        :items="items" :columns="columns"
        @items:new="items.push({})"
        @items:update="update"
        @columns:new="columns.push({ field: 'c-' + columns.length })"
      />
    </div>
  </div>
</template>
