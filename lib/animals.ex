defmodule Animals do
  @moduledoc """
  Documentation for `Animals`.
  """

  @spec create_zoo() :: list()
  @doc """
  create_zoo returns a list of zoo animals
  
  ## Examples
  
      iex> Animals.create_zoo
      ["lion", "tiger", "gorilla", "elephant", "monkey", "giraffe"]
  
  """
  def create_zoo do
    ["lion", "tiger", "gorilla", "elephant", "monkey", "giraffe"]
  end

  @spec randomise(list(String.t())) :: list(String.t())
  @doc """
  randomise takes a list of zoo animals and returns a new randomised list with
  the same elements as the first.
  
  ## Examples
  
      iex> zoo = Animals.create_zoo
      iex> Animals.randomise(zoo)
      ["monkey", "tiger", "elephant", "gorilla", "giraffe", "lion"]
  
  """
  def randomise(zoo) do
    Enum.shuffle(zoo)
  end

  @spec contains?(list(String.t()), String.t()) :: boolean()
  @doc """
  contains? takes a list of zoo animals and a single animal and returns a boolean
  as to whether or not the list contains the given animal.
  
  ## Examples
  
      iex> zoo = Animals.create_zoo
      iex> Animals.contains?(zoo, "gorilla")
      true
  """
  def contains?(zoo, animal) do
    Enum.member?(zoo, animal)
  end

  @spec see_animals(any(), number()) :: list(String.t())
  @doc """
  see_animals takes a list of zoo animals and the number of animals that
  you want to see and then returns a list
  
  ## Examples
  
      iex> zoo = Animals.create_zoo
      iex> Animals.see_animals(zoo, 2)
      ["monkey", "giraffe"]
  """
  def see_animals(zoo, count) do
    # Enum.split returns a tuple so we have to pattern match on the result
    # to get the value we want out
    {_seen, to_see} = Enum.split(zoo, -count)
    to_see
  end

  @spec save(list(String.t()), binary()) :: :ok | {:error, atom()}
  @doc """
  save takes a list of zoo animals and a filename and saves the list to that file
  
  ## Examples
  
      iex> zoo = Animals.create_zoo
      iex> Animals.save(zoo, "my_animals")
      :ok
  """
  def save(zoo, filename) do
    # erlang is converting the zoo list to something that can be written to the
    # file system
    binary = :erlang.term_to_binary(zoo)
    File.write(filename, binary)
  end

  @spec load(binary()) :: list(String.t()) | String.t()
  @doc """
  load takes filename and returns a list of animals if the file exists
  
  ## Examples
  
      iex> Animals.load("my_animals")
      ["lion", "tiger", "gorilla", "elephant", "monkey", "giraffe"]
      iex> Animals.load("aglkjhdfg")
      "File does not exist"
  
  """
  def load(filename) do
    # here we are running a case expression on the result of File.read(filename)
    # if we receive an :ok then we want to return the list
    # if we receive an error then we want to give the user an error-friendly message
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist"
    end
  end

  @spec selection(number()) :: list(String.t())
  @doc """
  selection takes a number, creates a zoo, randomises it and then returns a list
  of animals of length selected
  
  ## Examples
  
      iex> Animals.selection(2)
      ["gorilla", "giraffe"]
  
  """
  def selection(number_of_animals) do
    # We are using the pipe operator here. It takes the value returned from
    # the expression and passes it down as the first argument in the expression
    # below. see_animals takes two arguments but only one needs to be specified
    # as the first is provided by the pipe operator
    Animals.create_zoo()
    |> Animals.randomise()
    |> Animals.see_animals(number_of_animals)
  end
end
