From: Max Lapshin <max@flussonic.com>
Date: Thu, 13 Jun 2019 09:51:34 +0300
Subject: [Intel-wired-lan] i350 software defined pins sysfs access
In-Reply-To: <3827f4b8-506d-f55a-3279-f8a17699ee5e@silicom-usa.com>
References: <C0C7FF38-286F-46CA-909D-1A02EFDBBF0C@flussonic.com>
 <3827f4b8-506d-f55a-3279-f8a17699ee5e@silicom-usa.com>
Message-ID: <640C4F07-20AB-4D98-8A6D-770F0CE1C412@flussonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> 
> The igb driver already uses these pins for PTP if that's configured and
> the 82575 uses SDP3 as a power enable for SFP cages, sgmii PHYs, etc.
> You'll need to avoid letting userspace poke at SDPs that the driver is
> already using.

I should write code to avoid touching these registers for these cases?

> 
> Assuming this can coexist with the existing usage, why not register this
> as a gpio_chip with the gpiolib framework?

Ok, I will  take a look at it.


> 
>> Subject: [PATCH] i350: Add support for Intel i350 software defined pins
>> 
>> +
>> +/* Software defined pins 2-3 */
>> +#define IGB_CTRL_EXT_SDP2_DATA E1000_CTRL_EXT_SDP2_DATA /* Value of SW Defineable Pin 2 */
>> +#define IGB_CTRL_EXT_SDP3_DATA E1000_CTRL_EXT_SDP3_DATA /* Value of SW Defineable Pin 3 */
>> +#define IGB_CTRL_EXT_SDP2_DIR  E1000_CTRL_EXT_SDP2_DIR  /* SDP2 Data direction */
>> +#define IGB_CTRL_EXT_SDP3_DIR  E1000_CTRL_EXT_SDP3_DIR  /* SDP3 Data direction */
> 
> Looks like e1000_defines.h already has this info.
> 

Only partially, so I decided to copy it to avoid situtation then I have in one code  IGB_ and E1000_  defines.

It is not good?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190613/1fe61572/attachment.html>
