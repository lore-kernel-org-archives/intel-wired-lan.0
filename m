From: William Tu <u9012063@gmail.com>
Date: Tue, 2 Oct 2018 11:27:51 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/5] ixgbe: move common Rx
 functions to ixgbe_txrx_common.h
In-Reply-To: <20181002080034.11754-3-bjorn.topel@gmail.com>
References: <20181002080034.11754-1-bjorn.topel@gmail.com>
 <20181002080034.11754-3-bjorn.topel@gmail.com>
Message-ID: <CALDO+SYnd-eXNfhadkpCbWHVXfYXNfmUgP+_FN53FLxc1GbLRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 2, 2018 at 1:01 AM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> This patch prepares for the upcoming zero-copy Rx functionality, by
> moving/changing linkage of common functions, used both by the regular
> path and zero-copy path.
>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---

Thanks!
Tested-by: William Tu <u9012063@gmail.com>
