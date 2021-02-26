From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 26 Feb 2021 14:45:17 -0800
Subject: [Intel-wired-lan] [PATCH] igb: unbreak I2C bit-banging on i350
In-Reply-To: <5a9f1aed25a6df32337b9ac1140339d783abb6d8.1614279918.git.jan.kundrat@cesnet.cz>
References: <5a9f1aed25a6df32337b9ac1140339d783abb6d8.1614279918.git.jan.kundrat@cesnet.cz>
Message-ID: <20210226144517.00004a51@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Jan Kundr?t wrote:

> The driver tried to use Linux' native software I2C bus master
> (i2c-algo-bits) for exporting the I2C interface that talks to the SFP
> cage(s) towards userspace. As-is, however, the physical SCL/SDA pins
> were not moving at all, staying at logical 1 all the time.
> 
> The main culprit was the I2CPARAMS register where igb was not setting
> the I2CBB_EN bit. That meant that all the careful signal bit-banging was
> actually not being propagated to the chip pads (I verified this with a
> scope).
> 
> The bit-banging was not correct either, because I2C is supposed to be an
> open-collector bus, and the code was driving both lines via a totem
> pole. The code was also trying to do operations which did not make any
> sense with the i2c-algo-bits, namely manipulating both SDA and SCL from
> igb_set_i2c_data (which is only supposed to set SDA). I'm not sure if
> that was meant as an optimization, or was just flat out wrong, but given
> that the i2c-algo-bits is set up to work with a totally dumb GPIO-ish
> implementation underneath, there's no need for this code to be smart.
> 
> The open-drain vs. totem-pole is fixed by the usual trick where the
> logical zero is implemented via regular output mode and outputting a
> logical 0, and the logical high is implemented via the IO pad configured
> as an input (thus floating), and letting the mandatory pull-up resistors
> do the rest. Anything else is actually wrong on I2C where all devices
> are supposed to have open-drain connection to the bus.
> 
> The missing I2CBB_EN is set (along with a safe initial value of the
> GPIOs) just before registering this software I2C bus.
> 
> The chip datasheet mentions HW-implemented I2C transactions (SFP EEPROM
> reads and writes) as well, but I'm not touching these for simplicity.
> 
> Tested on a LR-Link LRES2203PF-2SFP (which is an almost-miniPCIe form
> factor card, a cable, and a module with two SFP cages). There was one
> casualty, an old broken SFP we had laying around, which was used to
> solder some thin wires as a DIY I2C breakout. Thanks for your service.
> With this patch in place, I can `i2cdump -y 3 0x51 c` and read back data
> which make sense. Yay.
> 
> Signed-off-by: Jan Kundr?t <jan.kundrat@cesnet.cz>
> See-also: https://www.spinics.net/lists/netdev/msg490554.html

Thanks for the patch! I'd like someone on our team to double check
things are working still on some of the stock Intel boards, but the code
changes look fine.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
