require_relative "../camel_snake"

RSpec.describe "camel case to snake case script functionality" do
    context 'the method that converts from camel to snake case' do

        let(:setup_files) do
            File.write('camel1', <<~CAMEL
            bigVar = 1000
            smallVar = 10
            onNextCall = ->(i) { i ** 2 }
            if bigVar > smallVar
                doSomething
            end
            CAMEL
        )

            File.write('snake1', <<~SNAKE
            big_var = 1000
            small_var = 10
            on_next_call = ->(i) { i ** 2 }
            if big_var > small_var
                do_something
            end
            SNAKE
        )

            File.write('camel2', <<~CAMEL
            thisArray = [1,2,3]
            thisArray.map! { |myVar| myVar + 1 }
            if true
            puts "hello"
            end
            CAMEL
        )

            File.write('snake2', <<~SNAKE
            this_array = [1,2,3]
            this_array.map! { |my_var| my_var + 1 }
            if true
            puts "hello"
            end
            SNAKE
        )
        end

        let(:delete_files) do
            File.delete('camel1')
            File.delete('camel2')
            File.delete('snake1')
            File.delete('snake2')
        end

        it 'converts camelCase to snake_case' do
            setup_files
            snake1 = File.read('snake1')
            expect(replace_case('camel1')).to eq(snake1)
            delete_files
        end
    end
end