describe('mountComponents', () => {
  beforeEach(() => {
    document.body.innerHTML = ''
  })

  it('does nothing when no data-vue-component elements exist', () => {
    const div = document.createElement('div')
    document.body.appendChild(div)
    expect(document.querySelectorAll('[data-vue-component]')).toHaveLength(0)
  })

  it('finds elements with the data-vue-component attribute', () => {
    const div = document.createElement('div')
    div.dataset.vueComponent = 'LoginForm'
    document.body.appendChild(div)

    const found = document.querySelectorAll('[data-vue-component]')
    expect(found).toHaveLength(1)
    expect((found[0] as HTMLElement).dataset.vueComponent).toBe('LoginForm')
  })

  it('dataset converts kebab-case attribute names to camelCase', () => {
    const div = document.createElement('div')
    div.dataset.vueComponent = 'TestComponent'
    expect(div.dataset.vueComponent).toBe('TestComponent')
  })
})
