From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 14 Sep 2021 23:37:46 +0000
Subject: [Intel-wired-lan] [PATCH intel-next 2/2] ice: add TTY device
 for GNSS module for E810T device
In-Reply-To: <20210913101108.17927-2-karol.kolacinski@intel.com>
References: <20210913101108.17927-1-karol.kolacinski@intel.com>
 <20210913101108.17927-2-karol.kolacinski@intel.com>
Message-ID: <e92f985f8cf8d7e2bfc33f97d572ae9da7a5d28b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-09-13 at 12:11 +0200, Karol Kolacinski wrote:
> Add a new ice_gnss.c file for holding the basic GNSS module
> functions.
> If the device supports GNSS module, call the new ice_gnss_init and
> ice_gnss_release functions where appropriate.
> 
> Implement basic functionality for reading the data from GNSS module
> using TTY device.
> 
> Future changes will introduce write functionality.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Sudhansu Sekhar Mishra <sudhansu.mishra@intel.com>
> Tested-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |   6 +
>  drivers/net/ethernet/intel/ice/ice_gnss.c | 373
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_gnss.h |  42 +++

Though you add the file, you're not compiling it:

ERROR: modpost: "ice_gnss_is_gps_present"
[drivers/net/ethernet/intel/ice/ice.ko] undefined!
ERROR: modpost: "ice_gnss_init" [drivers/net/ethernet/intel/ice/ice.ko]
undefined!
ERROR: modpost: "ice_gnss_exit" [drivers/net/ethernet/intel/ice/ice.ko]
undefined!

Adding it to compile, I'm getting a bunch of issues:

drivers/net/ethernet/intel/ice/ice_gnss.c: In function
ice_gnss_struct_init:
drivers/net/ethernet/intel/ice/ice_gnss.c:131:25: error: incompatible
types when assigning to type struct gnss_serial from type struct
gnss_serial *
  pf->gnss_serial[index] = gnss;
                         ^
drivers/net/ethernet/intel/ice/ice_gnss.c: In function
ice_gnss_tty_open:
drivers/net/ethernet/intel/ice/ice_gnss.c:168:7: error: incompatible
types when assigning to type struct gnss_serial * from type struct
gnss_serial
  gnss = pf->gnss_serial[tty->index];
       ^
In file included from ./include/linux/tty.h:10,
                 from drivers/net/ethernet/intel/ice/ice_gnss.h:7,
                 from drivers/net/ethernet/intel/ice/ice.h:69,
                 from drivers/net/ethernet/intel/ice/ice_gnss.c:4:
drivers/net/ethernet/intel/ice/ice_gnss.c: In function
ice_gnss_create_tty_driver:
drivers/net/ethernet/intel/ice/ice_gnss.c:264:32: error:
ICE_GNSS_TTY_MINOR_DEVICES undeclared (first use in this function); did
you mean ICE_DFLT_MIN_RX_DESC?
  tty_driver = tty_alloc_driver(ICE_GNSS_TTY_MINOR_DEVICES,
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/tty_driver.h:338:22: note: in definition of macro
tty_alloc_driver
   __tty_alloc_driver(lines, THIS_MODULE, flags)
                      ^~~~~
...

Not sure how this was tested.

>  drivers/net/ethernet/intel/ice/ice_main.c |  14 +
>  4 files changed, 435 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_gnss.c
>  create mode 100644 drivers/net/ethernet/intel/ice/ice_gnss.h

<snip>

> +/**
> + * ice_gnss_create_tty_driver - Create a TTY driver for GNSS
> + * @pf: Board private structure
> + */
> +static struct tty_driver *ice_gnss_create_tty_driver(struct ice_pf
> *pf)
> +{
> +	struct device *dev = ice_pf_to_dev(pf);
> +	struct tty_driver *tty_driver;
> +	int err;
> +	u8 i;
> +
> +	tty_driver = tty_alloc_driver(ICE_GNSS_TTY_MINOR_DEVICES,
> +				      TTY_DRIVER_REAL_RAW);
> +	if (!tty_driver) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"Failed to allocate memory for GNSS TTY\n");

nit: This can be one line

> +		return NULL;
> +	}
> +	/* Initialize the tty driver*/
> +	tty_driver->owner = THIS_MODULE;
> +	tty_driver->driver_name = dev_driver_string(dev);
> +	tty_driver->name = "ttyGNSS";
> +	tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
> +	tty_driver->subtype = SERIAL_TYPE_NORMAL;
> +	tty_driver->init_termios = tty_std_termios;
> +	tty_driver->init_termios.c_iflag &= ~INLCR;
> +	tty_driver->init_termios.c_iflag |= IGNCR;
> +	tty_driver->init_termios.c_oflag &= ~OPOST;
> +	tty_driver->init_termios.c_lflag &= ~ICANON;
> +	tty_driver->init_termios.c_cflag &= ~(CSIZE | CBAUD | CBAUDEX);
> +	/* baud rate 9600 */
> +	tty_termios_encode_baud_rate(&tty_driver->init_termios, 9600,
> 9600);
> +	tty_driver->driver_state = pf;
> +	tty_set_operations(tty_driver, &tty_gps_ops);
> +
> +	pf->gnss_serial = NULL;
> +
> +	tty_port_init(&pf->gnss_tty_port);
> +	tty_port_link_device(&pf->gnss_tty_port, tty_driver, 0);
> +
> +	err = tty_register_driver(tty_driver);
> +	if (err) {
> +		dev_err(ice_pf_to_dev(pf),
> +			"Failed to register TTY driver err=%d\n", err);

nit: This as well

> +
> +		tty_port_destroy(&pf->gnss_tty_port);
> +		put_tty_driver(tty_driver);
> +
> +		return NULL;
> +	}
> +
> +	return tty_driver;
> +}
> +
> +/**
> + * ice_gnss_init - Initialize GNSS TTY support
> + * @pf: Board private structure
> + */
> +void ice_gnss_init(struct ice_pf *pf)
> +{
> +	struct tty_driver *tty_driver;
> +
> +	tty_driver = ice_gnss_create_tty_driver(pf);
> +	if (!tty_driver)
> +		return;
> +
> +	pf->ice_gnss_tty_driver = tty_driver;
> +
> +	set_bit(ICE_FLAG_GNSS, pf->flags);
> +	dev_info(ice_pf_to_dev(pf), "GNSS TTY init successful\n");
> +}
> +
> +/**
> + * ice_gnss_exit - Disable GNSS TTY support
> + * @pf: Board private structure
> + */
> +void ice_gnss_exit(struct ice_pf *pf)
> +{
> +	u8 i;
> +
> +	if (!test_bit(ICE_FLAG_GNSS, pf->flags) || !pf-
> >ice_gnss_tty_driver)
> +		return;
> +
> +	tty_port_destroy(&pf->gnss_tty_port);
> +
> +	if (pf->gnss_serial) {
> +		struct gnss_serial *gnss = pf->gnss_serial;
> +
> +		kthread_cancel_delayed_work_sync(&gnss->read_work);
> +		kfree(gnss);
> +		pf->gnss_serial = NULL;
> +	}
> +
> +	tty_unregister_driver(pf->ice_gnss_tty_driver);
> +	put_tty_driver(pf->ice_gnss_tty_driver);
> +	pf->ice_gnss_tty_driver = NULL;
> +}
> +
> +/**
> + * ice_gnss_is_gps_present - Check if GPS HW is present
> + * @hw: pointer to HW struct
> + */
> +bool ice_gnss_is_gps_present(struct ice_hw *hw)
> +{
> +	if (!hw->func_caps.ts_func_info.src_tmr_owned)
> +		return false;
> +
> +	if (ice_is_e810t(hw)) {
> +		enum ice_status status;
> +			u8 data;

Indentation is off

