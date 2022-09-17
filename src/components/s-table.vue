<script setup lang="ts">
import { ref } from 'vue';

interface Column {
    field?: string
    type?: string,
    options?: string[]
}

const props = defineProps({
    items: {
        type: Array as () => Record<string, string>[],
        default: () => []
    },
    columns: {
        type: Array as () => Column[],
        default: () => []
    },
})

const emit = defineEmits([
    'items:new',
    'items:update',
    'columns:new'
])

const active = ref([-1, -1])

function isActive(itemIndex: number, columnIndex: number, ) {
    return active.value[0] == itemIndex && active.value[1] === columnIndex
}

function setActive(itemIndex: number, columnIndex: number, ) {
    active.value[0] = itemIndex
    active.value[1] = columnIndex
}

function updateItem(index: number, field: string, value: any){

    emit('items:update', {
        index,
        data: {
            [field]: value
        }
    })
}

function unsetActive(index: number, columnIndex: number) {
    setTimeout(() => {
        if (isActive(index, columnIndex)) active.value = [-1, -1]
    }, 100)
}

</script>
<template>
  <table class="drop-shadow bg-white w-full">
    <thead>
        <tr class="border-b">
            <td
                v-for="(column, index) in columns"
                :key="index"
                class="border-r font-bold p-2"
            >
                {{ column.field }}
            </td>

            <td
                class="border p-2 cursor-pointer hover:bg-gray-100"
                @click="$emit('columns:new')"            
            >
                +
        
            </td>

        </tr>
    </thead>
    
    <tr v-for="(item, index) in items" :key="index">
        <td
            v-for="(column, cIndex) in columns"
            :key="cIndex"
            class="border  hover:bg-gray-100 w-40"
            :class="isActive(index, cIndex) ? 'outline outline-1 outline-teal-500' : '' "
        >
            <div v-if="!column.field" />
            
            <select
                v-else-if="column.type === 'select'"
                class="p-2 bg-transparent outline-none focus:outline-none w-full"          
                :value="item[column.field]"
                @change="e => updateItem(index, column.field!, (e.target as any).value)"
            >
                <option
                    v-for="option in column.options"
                    :value="option"
                >
                    {{option}}
                </option>
                
            </select>
        
            <input
                v-else
                :value="item[column.field]"
                class="p-2 bg-transparent outline-none focus:outline-none w-full"
                :class="isActive(index, cIndex) ? 'cursor-auto' : 'cursor-default' "
                @change="e => updateItem(index, column.field!, (e.target as any).value)"
                @focus="setActive(index, cIndex)"
                @blur="unsetActive(index, cIndex)"
                @keyup.shift.enter="$emit('items:new')"
            >

        </td>

        <td class="border p-2"></td>
    </tr>

    <tr>
        <td
            class="border p-2 cursor-pointer hover:bg-gray-100"
            :colspan="columns.length + 1"
            @click="$emit('items:new')"
        >
            + New
        </td>
    </tr>
  </table>  
</template>