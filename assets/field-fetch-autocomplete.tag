<field-fetch-autocomplete>
  <div class="uk-margin uk-panel uk-panel-card uk-panel-box" if="{item}">
    <div class="uk-flex">
      <span class="uk-flex-item-1">
        {item}
      </span>
      <a class="uk-margin-small-left uk-text-danger" role="button" onclick="{ clearEntry }">
        <i class="uk-icon-trash-o" />
      </a>
    </div>
  </div>
  <div ref="autocomplete" class="uk-autocomplete uk-form uk-form-icon app-search">
      <style>
          .uk-autocomplete .uk-dropdown {
            min-width: 25vw;
          }
      </style>
      <i class="uk-icon-search"></i>
      <input
        ref="input"
        id="searchInput"
        name="searchInput"
        autocomplete="off"
        class="uk-width-1-1 uk-form-blank"
        type="text"
        aria-label="{App.i18n.get('Search for an item...')}"
        placeholder="{ App.i18n.get('Search for an item...') }">
  </div>
  <script>
    var $this = this;
    var item;
    this.getData = function(release) {
      if($this.opts.url && this.value) {
        var url = new URL($this.opts.url);
        var params = {
          [$this.opts.param || 'search']: this.value,
          [$this.opts.limit || 'limit']: 6
        };
        Object.keys(params).forEach(key => url.searchParams.append(key, params[key]))
        fetch(url)
          .then(function(response) {
            return response.json()
          })
          .then(function(response) {
            var items =  ($this.opts.root || '').split('.').reduce((o, i) => o[i], response) || response;
            if(items && items.length > 0) {
              var result = items.map(function(item) {
                return {
                  value: item[$this.opts.value || 'value'],
                  title: item[$this.opts.title || 'title']
                }
              })
              release(result)
              return;
            }
          })
      }
      release([]);
    }

    this.clearEntry = function(event) {
      event.preventDefault();
      $this.item = null;
      $this.$setValue(null, false, opts.bind);
      $this.$setValue(null, false, opts.bind + '_title');
      console.log('clear', $this.item);
    }

    this.on('mount', function() {
      this.item = this.$getValue(opts.bind + '_title');
      console.log(this.item);
      UIkit.autocomplete(this.refs.autocomplete, {
          source: this.getData,
          template: '<ul class="uk-nav uk-nav-autocomplete uk-autocomplete-results">{{~items}}<li data-title="{{$item.title}}" data-value="{{$item.value}}"><a>{{$item.title}}</a></li>{{/items}}</ul>'
      });
    });

    App.$(this.root).on("selectitem.uk.autocomplete", function(e, data) {
      $this.item = data.title;
      $this.$setValue(data.value, false, opts.bind);
      $this.$setValue(data.title, false, opts.bind + '_title');
      setTimeout(function() {
        $this.refs.input.value = ''
      },0);
    });
  </script>
</field-fetch-autocomplete>