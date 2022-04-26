From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Tue, 26 Apr 2022 14:09:49 -0700
Subject: [Intel-wired-lan] [PATCH v3 intel-next 3/3] ice: add write
 functionality for GNSS TTY
In-Reply-To: <20220426123556.3041070-3-karol.kolacinski@intel.com>
References: <20220426123556.3041070-1-karol.kolacinski@intel.com>
 <20220426123556.3041070-3-karol.kolacinski@intel.com>
Message-ID: <b04bceb5-3523-a034-b99b-c4acb847bc64@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/26/2022 5:35 AM, Karol Kolacinski wrote:

<snip>
> +static unsigned int
> +ice_gnss_do_write(struct ice_pf *pf, unsigned char *buf, unsigned int size)
> +{
> +	struct ice_aqc_link_topo_addr link_topo;
> +	struct ice_hw *hw = &pf->hw;
> +	unsigned int offset = 0;
> +	int err = 0;
> +
> +	memset(&link_topo, 0, sizeof(struct ice_aqc_link_topo_addr));
> +	link_topo.topo_params.index = ICE_E810T_GNSS_I2C_BUS;
> +	link_topo.topo_params.node_type_ctx |=
> +		ICE_AQC_LINK_TOPO_NODE_CTX_OVERRIDE <<
> +		ICE_AQC_LINK_TOPO_NODE_CTX_S;

I believe there's a macro that can replace this... FIELD_PREP?

<snip>

> @@ -74,7 +166,7 @@ static void ice_gnss_read(struct kthread_work *work)
>   
>   	/* Read received data */
>   	for (i = 0; i < data_len; i += bytes_read) {
> -		u32 bytes_left = data_len - i;
> +		unsigned int bytes_left = data_len - i;
>   
>   		bytes_read = min_t(typeof(bytes_left), bytes_left,
>   				   ICE_MAX_I2C_DATA_SIZE);

Should this be with patch 1?

<snip>

> @@ -212,25 +307,100 @@ static void ice_gnss_tty_close(struct tty_struct *tty, struct file *filp)
>   }
>   
>   /**
> - * ice_gnss_tty_write - Dummy TTY write function to avoid kernel panic
> + * ice_gnss_tty_write - Write GNSS data
>    * @tty: pointer to the tty_struct
>    * @buf: pointer to the user data
> - * @cnt: the number of characters that was able to be sent to the hardware (or
> - *       queued to be sent at a later time)
> + * @count: the number of characters queued to be sent to the HW
> + *
> + * The write function call is called by the user when there is data to be sent
> + * to the hardware. First the tty core receives the call, and then it passes the
> + * data on to the tty driver?s write function. The tty core also tells the tty
> + * driver the size of the data being sent.
> + * If any errors happen during the write call, a negative error value should be
> + * returned instead of the number of characters queued to be written.
>    */
>   static int
> -ice_gnss_tty_write(struct tty_struct *tty, const unsigned char *buf, int cnt)
> +ice_gnss_tty_write(struct tty_struct *tty, const unsigned char *buf, int count)
>   {
> -	return 0;
> +	struct gnss_write_buf *write_buf;
> +	struct gnss_serial *gnss;
> +	unsigned char *cmd_buf;
> +	struct ice_pf *pf;
> +	int err = count;
> +
> +	/* We cannot write a single byte using our I2C implementation. */
> +	if (count <= 1 || count > ICE_GNSS_TTY_WRITE_BUF)
> +		return -EINVAL;
> +
> +	gnss = tty->driver_data;
> +	if (!gnss)
> +		return -EFAULT;
> +
> +	pf = (struct ice_pf *)tty->driver->driver_state;
> +	if (!pf)
> +		return -EFAULT;
> +
> +	/* Only allow to write on TTY 0 */
> +	if (gnss != pf->gnss_serial[0])
> +		return -EIO;
> +
> +	mutex_lock(&gnss->gnss_mutex);
> +
> +	if (!gnss->open_count) {
> +		err = -EINVAL;
> +		goto exit;
> +	}
> +
> +	cmd_buf = kzalloc(sizeof(*buf) * count, GFP_KERNEL);

I believe kcalloc is preferred.


Thanks,

Tony

