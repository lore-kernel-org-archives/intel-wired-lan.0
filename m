From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 15 Apr 2022 19:11:48 +0200
Subject: [Intel-wired-lan] [PATCH intel-next 3/3] ice: add write
 functionality for GNSS TTY
In-Reply-To: <20220415103139.794790-3-karol.kolacinski@intel.com>
References: <20220415103139.794790-1-karol.kolacinski@intel.com>
 <20220415103139.794790-3-karol.kolacinski@intel.com>
Message-ID: <b57eb24a-f7de-ab5c-7da9-fea49a6bc17a@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Karol,


Thank you for the patch.

Am 15.04.22 um 12:31 schrieb Karol Kolacinski:
> Add the possibility to write raw bytes to the GNSS module through the
> first TTY device. This allow user to configure the module.

allow*s*

> 
> Create a second read-only TTY device.

Could you please give an example how to configure the module?

> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice.h      |   4 +-
>   drivers/net/ethernet/intel/ice/ice_gnss.c | 230 +++++++++++++++++++---
>   drivers/net/ethernet/intel/ice/ice_gnss.h |  23 ++-
>   3 files changed, 231 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index 17fb1ddea7b0..41bd0c7c7da5 100644
> --- a/drivers/net/ethernet/intel/ice/ice.h
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -558,8 +558,8 @@ struct ice_pf {
>   	u32 msg_enable;
>   	struct ice_ptp ptp;
>   	struct tty_driver *ice_gnss_tty_driver;
> -	struct tty_port gnss_tty_port;
> -	struct gnss_serial *gnss_serial;
> +	struct tty_port *gnss_tty_port[ICE_GNSS_TTY_MINOR_DEVICES];
> +	struct gnss_serial *gnss_serial[ICE_GNSS_TTY_MINOR_DEVICES];
>   	u16 num_rdma_msix;		/* Total MSIX vectors for RDMA driver */
>   	u16 rdma_base_vector;
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
> index f0b2091c3b5f..eafebd873236 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.c
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
> @@ -5,6 +5,99 @@
>   #include "ice_lib.h"
>   #include <linux/tty_driver.h>
>   
> +/**
> + * ice_gnss_do_write - Write data to internal GNSS
> + * @pf: board private structure
> + * @buf: command buffer
> + * @size: command buffer size
> + *
> + * Write UBX command data to the GNSS receiver
> + */
> +static void ice_gnss_do_write(struct ice_pf *pf, u8 *buf, u32 size)
> +{
> +	u32 i, num_writes, part_writes_num, last_write_bytes, offset = 0;

Can native types be used at least for the loop variable?

Write out `partial_writes_num`?

> +	struct ice_aqc_link_topo_addr link_topo;
> +	struct ice_hw *hw = &pf->hw;
> +	int err = 0;
> +
> +	memset(&link_topo, 0, sizeof(struct ice_aqc_link_topo_addr));
> +	link_topo.topo_params.index = ICE_E810T_GNSS_I2C_BUS;
> +	link_topo.topo_params.node_type_ctx |=
> +		ICE_AQC_LINK_TOPO_NODE_CTX_OVERRIDE <<
> +		ICE_AQC_LINK_TOPO_NODE_CTX_S;
> +
> +	/* Write all bytes except the last partial write */
> +	last_write_bytes = size % ICE_GNSS_UBX_WRITE_BYTES;
> +	if (last_write_bytes == 0)
> +		part_writes_num = 0;
> +	else if (last_write_bytes == 1)
> +		part_writes_num = 2;
> +	else
> +		part_writes_num = 1;

I do not fully understand the formula. But I am ignorant, so please 
ignore, if it?s obvious.

> +
> +	num_writes = size / ICE_GNSS_UBX_WRITE_BYTES - part_writes_num;
> +
> +	for (i = 0; i < num_writes; i++) {
> +		err = ice_aq_write_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
> +				       cpu_to_le16(buf[offset]),
> +				       ICE_MAX_I2C_WRITE_BYTES,
> +				       &buf[offset + 1], NULL);
> +		if (err)
> +			goto err;
> +
> +		offset += ICE_GNSS_UBX_WRITE_BYTES;
> +	}
> +
> +	if (part_writes_num == 2) {
> +		/* We cannot write a single byte to ublox. Do 2 last writes
> +		 * instead of 1.
> +		 */
> +		err = ice_aq_write_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
> +				       cpu_to_le16(buf[offset]),
> +				       ICE_MAX_I2C_WRITE_BYTES - 1,
> +				       &buf[offset + 1], NULL);
> +		if (err)
> +			goto err;
> +
> +		offset += ICE_GNSS_UBX_WRITE_BYTES - 1;
> +		last_write_bytes = 2;
> +	}
> +
> +	if (part_writes_num)

Please add a comment here, how you the logic works (that 
`part_writes_num == 2` is also effected).

> +		err = ice_aq_write_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
> +				       cpu_to_le16(buf[offset]),
> +				       last_write_bytes - 1, &buf[offset + 1],
> +				       NULL);
> +

I wonder if some kind of while could model the algorithm better.

> +err:
> +	if (err)
> +		dev_err(ice_pf_to_dev(pf), "GNSS failed to write err=%d\n",
> +			err);

Please add the offset, and other values to the message.

> +}
> +
> +/**
> + * ice_gnss_write_pending - Write all pending data to internal GNSS
> + * @work: GNSS write work structure
> + */
> +static void ice_gnss_write_pending(struct kthread_work *work)
> +{
> +	struct gnss_serial *gnss = container_of(work, struct gnss_serial,
> +						write_work);
> +	struct ice_pf *pf = gnss->back;
> +
> +	if (!list_empty(&gnss->queue)) {
> +		struct gnss_write_buf *write_buf = NULL;
> +
> +		write_buf = list_first_entry(&gnss->queue,
> +					     struct gnss_write_buf, queue);
> +		list_del(&write_buf->queue);

Why does the queue need to be deleted here, and not after the write below?

> +
> +		ice_gnss_do_write(pf, write_buf->buf, write_buf->size);

Should `ice_gnss_do_write` return some success/failure code, or the 
number of writes?

> +		kfree(write_buf->buf);
> +		kfree(write_buf);
> +	}
> +}
> +
>   /**
>    * ice_gnss_read - Read data from internal GNSS module
>    * @work: GNSS read work structure
> @@ -103,8 +196,9 @@ static void ice_gnss_read(struct kthread_work *work)
>   /**
>    * ice_gnss_struct_init - Initialize GNSS structure for the TTY
>    * @pf: Board private structure
> + * @index: TTY device index
>    */
> -static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf)
> +static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf, int index)
>   {
>   	struct device *dev = ice_pf_to_dev(pf);
>   	struct kthread_worker *kworker;
> @@ -117,9 +211,11 @@ static struct gnss_serial *ice_gnss_struct_init(struct ice_pf *pf)
>   	mutex_init(&gnss->gnss_mutex);
>   	gnss->open_count = 0;
>   	gnss->back = pf;
> -	pf->gnss_serial = gnss;
> +	pf->gnss_serial[index] = gnss;
>   
>   	kthread_init_delayed_work(&gnss->read_work, ice_gnss_read);
> +	INIT_LIST_HEAD(&gnss->queue);
> +	kthread_init_work(&gnss->write_work, ice_gnss_write_pending);
>   	/* Allocate a kworker for handling work required for the GNSS TTY
>   	 * writes.
>   	 */
> @@ -155,10 +251,10 @@ static int ice_gnss_tty_open(struct tty_struct *tty, struct file *filp)
>   	tty->driver_data = NULL;
>   
>   	/* Get the serial object associated with this tty pointer */
> -	gnss = pf->gnss_serial;
> +	gnss = pf->gnss_serial[tty->index];
>   	if (!gnss) {
>   		/* Initialize GNSS struct on the first device open */
> -		gnss = ice_gnss_struct_init(pf);
> +		gnss = ice_gnss_struct_init(pf, tty->index);
>   		if (!gnss)
>   			return -ENOMEM;
>   	}
> @@ -211,25 +307,96 @@ static void ice_gnss_tty_close(struct tty_struct *tty, struct file *filp)
>   }
>   
>   /**
> - * ice_gnss_tty_write - Dummy TTY write function to avoid kernel panic
> + * ice_gnss_tty_write - Write GNSS data
>    * @tty: pointer to the tty_struct
>    * @buf: pointer to the user data
>    * @cnt: the number of characters that was able to be sent to the hardware (or

s/was/were/

>    *       queued to be sent at a later time)

But you are passing `cnt` in, and not set it in the implementation 
below, aren?t you?

> + *
> + * The write function call is called by the user when there is data to be sent
> + * to the hardware. First the tty core receives the call, and then it passes the
> + * data on to the tty driver?s write function. The tty core also tells the tty
> + * driver the size of the data being sent.
> + * If any errors happen during the write call, a negative error value should be
> + * returned instead of the number of characters that were written.
>    */
>   static int
>   ice_gnss_tty_write(struct tty_struct *tty, const unsigned char *buf, int cnt)

Should `cnt` be unsigned? Also, I?d use `count`.

>   {
> -	return 0;
> +	struct gnss_write_buf *write_buf;
> +	struct gnss_serial *gnss;
> +	struct ice_pf *pf;
> +	u8 *cmd_buf;
> +
> +	/* We cannot write a single byte using our I2C implementation. */
> +	if (cnt <= 1 || cnt > ICE_GNSS_TTY_WRITE_BUF)
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
> +	/* Allow write only on TTY 0 */

Only allow to write on TTY 0

> +	if (gnss != pf->gnss_serial[0])
> +		return -EIO;
> +
> +	mutex_lock(&gnss->gnss_mutex);
> +
> +	if (!gnss->open_count) {
> +		mutex_unlock(&gnss->gnss_mutex);
> +		return -EINVAL;
> +	}
> +
> +	cmd_buf = kzalloc(sizeof(*buf) * cnt, GFP_KERNEL);
> +	if (!cmd_buf)
> +		return -ENOMEM;

Does some unlocking need to happen here?

> +
> +	memcpy(cmd_buf, buf, cnt);
> +
> +	/* Send the data out to a hardware port */
> +	write_buf = kzalloc(sizeof(*write_buf), GFP_KERNEL);
> +	if (!write_buf)
> +		return -ENOMEM;

Ditto.

> +
> +	write_buf->buf = cmd_buf;
> +	write_buf->size = cnt;
> +	INIT_LIST_HEAD(&write_buf->queue);
> +	list_add_tail(&write_buf->queue, &gnss->queue);
> +	kthread_queue_work(gnss->kworker, &gnss->write_work);
> +	mutex_unlock(&gnss->gnss_mutex);
> +	return cnt;
>   }
>   
>   /**
> - * ice_gnss_tty_write_room - Dummy TTY write_room function to avoid kernel panic
> + * ice_gnss_tty_write_room - Returns the numbers of characters to be written.
>    * @tty: pointer to the tty_struct
> + *
> + * This routine returns the numbers of characters the tty driver will accept
> + * for queuing to be written. This number is subject to change as output buffers
> + * get emptied, or if the output flow control is acted.

What do you mean by ?is acted??

>    */
>   static unsigned int ice_gnss_tty_write_room(struct tty_struct *tty)
>   {
> -	return 0;
> +	struct gnss_serial *gnss = tty->driver_data;
> +	unsigned int room = 0;
> +
> +	/* Allow write only on TTY 0 */

Ditto.

> +	if (!gnss || gnss != gnss->back->gnss_serial[0])
> +		return room;

Do you need `room`? `return 0` here, and the macro in the end?

> +
> +	mutex_lock(&gnss->gnss_mutex);
> +
> +	if (!gnss->open_count)
> +		goto exit;
> +
> +	room = ICE_GNSS_TTY_WRITE_BUF;
> +exit:
> +	mutex_unlock(&gnss->gnss_mutex);
> +	return room;
>   }
>   
>   static const struct tty_operations tty_gps_ops = {
> @@ -250,10 +417,12 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
>   	struct tty_driver *tty_driver;
>   	char *ttydrv_name;
>   	int err;
> +	u32 i;

Use native types?

>   
> -	tty_driver = tty_alloc_driver(1, TTY_DRIVER_REAL_RAW);
> +	tty_driver = tty_alloc_driver(ICE_GNSS_TTY_MINOR_DEVICES,
> +				      TTY_DRIVER_REAL_RAW);
>   	if (IS_ERR(tty_driver)) {
> -		dev_err(ice_pf_to_dev(pf), "Failed to allocate memory for GNSS TTY\n");
> +		dev_err(dev, "Failed to allocate memory for GNSS TTY\n");
>   		return NULL;
>   	}
>   
> @@ -283,23 +452,32 @@ static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf *pf)
>   	tty_driver->driver_state = pf;
>   	tty_set_operations(tty_driver, &tty_gps_ops);
>   
> -	pf->gnss_serial = NULL;
> +	for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++) {
> +		pf->gnss_tty_port[i] = kzalloc(sizeof(*pf->gnss_tty_port[i]),
> +					       GFP_KERNEL);
> +		pf->gnss_serial[i] = NULL;
>   
> -	tty_port_init(&pf->gnss_tty_port);
> -	tty_port_link_device(&pf->gnss_tty_port, tty_driver, 0);
> +		tty_port_init(pf->gnss_tty_port[i]);
> +		tty_port_link_device(pf->gnss_tty_port[i], tty_driver, i);
> +	}
>   
>   	err = tty_register_driver(tty_driver);
>   	if (err) {
> -		dev_err(ice_pf_to_dev(pf), "Failed to register TTY driver err=%d\n",
> -			err);
> +		dev_err(dev, "Failed to register TTY driver err=%d\n", err);
>   
> -		tty_port_destroy(&pf->gnss_tty_port);
> +		for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++) {
> +			tty_port_destroy(pf->gnss_tty_port[i]);
> +			kfree(pf->gnss_tty_port[i]);
> +		}
>   		kfree(ttydrv_name);
>   		tty_driver_kref_put(pf->ice_gnss_tty_driver);
>   
>   		return NULL;
>   	}
>   
> +	for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++)
> +		dev_info(dev, "%s%d registered\n", ttydrv_name, i);
> +
>   	return tty_driver;
>   }
>   
> @@ -327,17 +505,25 @@ void ice_gnss_init(struct ice_pf *pf)
>    */
>   void ice_gnss_exit(struct ice_pf *pf)
>   {
> +	u32 i;

Ditto.

> +
>   	if (!test_bit(ICE_FLAG_GNSS, pf->flags) || !pf->ice_gnss_tty_driver)
>   		return;
>   
> -	tty_port_destroy(&pf->gnss_tty_port);
> +	for (i = 0; i < ICE_GNSS_TTY_MINOR_DEVICES; i++) {
> +		if (pf->gnss_tty_port[i]) {
> +			tty_port_destroy(pf->gnss_tty_port[i]);
> +			kfree(pf->gnss_tty_port[i]);
> +		}
>   
> -	if (pf->gnss_serial) {
> -		struct gnss_serial *gnss = pf->gnss_serial;
> +		if (pf->gnss_serial[i]) {
> +			struct gnss_serial *gnss = pf->gnss_serial[i];
>   
> -		kthread_cancel_delayed_work_sync(&gnss->read_work);
> -		kfree(gnss);
> -		pf->gnss_serial = NULL;
> +			kthread_cancel_work_sync(&gnss->write_work);
> +			kthread_cancel_delayed_work_sync(&gnss->read_work);
> +			kfree(gnss);
> +			pf->gnss_serial[i] = NULL;
> +		}
>   	}
>   
>   	tty_unregister_driver(pf->ice_gnss_tty_driver);
> diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/ethernet/intel/ice/ice_gnss.h
> index 9211adb2372c..59ba5749143e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_gnss.h
> +++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
> @@ -8,14 +8,31 @@
>   #include <linux/tty_flip.h>
>   
>   #define ICE_E810T_GNSS_I2C_BUS		0x2
> +#define ICE_GNSS_TIMER_DELAY_TIME	(HZ / 10) /* 0.1 second per message */
> +#define ICE_GNSS_TTY_MINOR_DEVICES	2
> +#define ICE_GNSS_TTY_WRITE_BUF		250
> +#define ICE_MAX_I2C_DATA_SIZE		FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M)
> +#define ICE_MAX_I2C_WRITE_BYTES		4
> +
> +/* ublox specific deifinitions */
>   #define ICE_GNSS_UBX_I2C_BUS_ADDR	0x42
>   /* Data length register is big endian */
>   #define ICE_GNSS_UBX_DATA_LEN_H		0xFD
>   #define ICE_GNSS_UBX_DATA_LEN_WIDTH	2
>   #define ICE_GNSS_UBX_EMPTY_DATA		0xFF
> -#define ICE_GNSS_TIMER_DELAY_TIME	(HZ / 10) /* 0.1 second per message */
> -#define ICE_MAX_I2C_DATA_SIZE		FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M)
> +/* For ublox writes are performed without address so the first byte to write is
> + * passed as I2C addr parameter.
> + */
> +#define ICE_GNSS_UBX_WRITE_BYTES	(ICE_MAX_I2C_WRITE_BYTES + 1)
>   #define ICE_MAX_UBX_READ_TRIES		255
> +#define ICE_MAX_UBX_ACK_READ_TRIES	4095
> +
> +struct gnss_write_buf {
> +	struct list_head queue;
> +	u32 size;

Use native types.

> +	u8 *buf;
> +};
> +
>   
>   /**
>    * struct gnss_serial - data used to initialize GNSS TTY port
> @@ -33,6 +50,8 @@ struct gnss_serial {
>   	struct mutex gnss_mutex; /* protects GNSS serial structure */
>   	struct kthread_worker *kworker;
>   	struct kthread_delayed_work read_work;
> +	struct kthread_work write_work;
> +	struct list_head queue;
>   };
>   
>   #if IS_ENABLED(CONFIG_TTY)


Kind regards,

Paul
