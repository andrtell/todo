defmodule TodoWeb.Components do
  use Phoenix.Component

  attr :class, :string, default: ""
  attr :rest, :global

  slot :inner_block, required: true

  def button(assigns) do
    ~H"""
    <button class={[@class, "box center"]} {@rest}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  attr :class, :string, default: ""
  attr :rest, :global

  def svg_blank(assigns) do
    ~H"""
    <svg
      {@rest}
      class={@class}
      width="1rem"
      height="1rem"
      viewBox="0 0 24 24"
      stroke="currentcolor"
      xmlns="http://www.w3.org/2000/svg"
    >
    </svg>
    """
  end

  attr :class, :string, default: ""
  attr :rest, :global

  def svg_plus(assigns) do
    ~H"""
    <svg
      {@rest}
      class={@class}
      width="1rem"
      height="1rem"
      viewBox="0 0 24 24"
      stroke="currentcolor"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M0 12H24M12 0V24"
        stroke="currentcolor"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      />
    </svg>
    """
  end

  attr :class, :string, default: ""
  attr :rest, :global

  def svg_minus(assigns) do
    ~H"""
    <svg
      {@rest}
      class={@class}
      width="1rem"
      height="1rem"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentcolor"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M0 12L24 12"
        stroke-width="2"
        stroke-linecap="round"
        stroke-linejoin="round"
      >
      </path>
    </svg>
    """
  end

  attr :class, :string, default: ""
  attr :rest, :global

  def svg_checkmark(assigns) do
    ~H"""
    <svg
      {@rest}
      class={["icon", @class]}
      width="1rem"
      height="1rem"
      viewBox="0 0 1920 1920"
      fill="currentColor"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M1743.858 267.012 710.747 1300.124 176.005 765.382 0 941.387l710.747 710.871 1209.24-1209.116z"
        stroke-width="5"
      />
    </svg>
    """
  end
end
