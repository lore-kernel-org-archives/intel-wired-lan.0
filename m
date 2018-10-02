From: William Tu <u9012063@gmail.com>
Date: Tue, 2 Oct 2018 11:25:12 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/5] ixgbe: added Rx/Tx ring
 disable/enable functions
In-Reply-To: <20181002080034.11754-2-bjorn.topel@gmail.com>
References: <20181002080034.11754-1-bjorn.topel@gmail.com>
 <20181002080034.11754-2-bjorn.topel@gmail.com>
Message-ID: <CALDO+Sbjrf5ubitwkVfiQ2QpbrYQ9p0GET+XoT1EOOU2Xsqhxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 2, 2018 at 1:01 AM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> Add functions for Rx/Tx ring enable/disable. Instead of resetting the
> whole device, only the affected ring is disabled or enabled.
>
> This plumbing is used in later commits, when zero-copy AF_XDP support
> is introduced.
>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>

Thanks!
Tested-by: William Tu <u9012063@gmail.com>
