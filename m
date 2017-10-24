From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 24 Oct 2017 09:04:52 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: add bounds check for debugfs
 register access
In-Reply-To: <1508772069-4448-1-git-send-email-paul.greenwalt@intel.com>
References: <1508772069-4448-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <CAKgT0Ufx4TE=__NKkdKQnY9UtcqWz3H7kJvj7z1MPH4VTas2pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 23, 2017 at 8:21 AM, Paul Greenwalt
<paul.greenwalt@intel.com> wrote:
> Add bounds check for debugfs read and write register access.
>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
> index 5e2c1e3..4fcd980 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_debugfs.c
> @@ -103,7 +103,8 @@ static ssize_t ixgbe_dbg_reg_ops_write(struct file *filp,
>                 u32 reg, value;
>                 int cnt;
>                 cnt = sscanf(&ixgbe_dbg_reg_ops_buf[5], "%x %x", &reg, &value);
> -               if (cnt == 2) {
> +               /* check format and bounds check register access */
> +               if (cnt == 2 && reg <= IXGBE_HFDR) {
>                         IXGBE_WRITE_REG(&adapter->hw, reg, value);
>                         value = IXGBE_READ_REG(&adapter->hw, reg);
>                         e_dev_info("write: 0x%08x = 0x%08x\n", reg, value);
> @@ -114,7 +115,8 @@ static ssize_t ixgbe_dbg_reg_ops_write(struct file *filp,
>                 u32 reg, value;
>                 int cnt;
>                 cnt = sscanf(&ixgbe_dbg_reg_ops_buf[4], "%x", &reg);
> -               if (cnt == 1) {
> +               /* check format and bounds check register access */
> +               if (cnt == 1 && reg <= IXGBE_HFDR) {
>                         value = IXGBE_READ_REG(&adapter->hw, reg);
>                         e_dev_info("read 0x%08x = 0x%08x\n", reg, value);
>                 } else {

Not to be snarky, but there is actually for this there is an easier
fix. Just remove the ability to write registers from debugfs. Stuff
like this isn't supposed to be in debugfs. It isn't a configuration
interface. That is the feedback you will probably get from the
community anyway on this patch.

- Alex
