def set_figure_handle(fig,
                      width: float = 5.0,
                      height: float = 5.0,
                      unit_cm: bool = True):

    if unit_cm:
        cf = 1/2.54
    else:
        cf = 1

    fig.set_size_inches(width * cf, height * cf)

    return fig
