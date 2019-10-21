from typing import List, Dict


def set_axes_handle(ax,
                    font_name: str = 'DejaVu Sans',
                    font_size: int = 10,
                    line_width: float = 1.0,
                    tick_length: float = None):

    # Adapt font
    ax.xaxis.label.set_fontname(font_name)
    ax.yaxis.label.set_fontname(font_name)

    # Adapt font size
    ax.xaxis.label.set_fontsize(font_size)
    ax.yaxis.label.set_fontsize(font_size)
    ax.tick_params(axis='both', labelsize=font_size)

    # Remove top and right spines
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)

    # Adapt line width
    for axis in ['top', 'bottom', 'left', 'right']:
        ax.spines[axis].set_linewidth(line_width)

    return ax


def set_axes_handles(axs,
                     params: List[Dict] = None):

    for ax_idx, ax in enumerate(axs):
        axs[ax_idx] = set_axes_handle(ax, **params[ax_idx])

    return axs



