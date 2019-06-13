From: Stephen Douthit <stephend@silicom-usa.com>
Date: Thu, 13 Jun 2019 14:02:09 +0000
Subject: [Intel-wired-lan] i350 software defined pins sysfs access
In-Reply-To: <640C4F07-20AB-4D98-8A6D-770F0CE1C412@flussonic.com>
References: <C0C7FF38-286F-46CA-909D-1A02EFDBBF0C@flussonic.com>
 <3827f4b8-506d-f55a-3279-f8a17699ee5e@silicom-usa.com>
 <640C4F07-20AB-4D98-8A6D-770F0CE1C412@flussonic.com>
Message-ID: <91ca0c21-d1c2-bf4d-0a0a-6c04c65381d1@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/13/19 2:51 AM, Max Lapshin wrote:
> 
>>
>> The igb driver already uses these pins for PTP if that's configured and
>> the 82575 uses SDP3 as a power enable for SFP cages, sgmii PHYs, etc.
>> You'll need to avoid letting userspace poke at SDPs that the driver is
>> already using.
> 
> I should write code to avoid touching these registers for these cases?

If you use the gpiolib framework, then I believe refactoring the
existing SDP peeks/pokes in the igb driver to use gpio descriptors
should take care of this for you.  In the cases where the driver needs
the SDPs it will have already requested those gpio descriptors and they
won't be available to other requesters like user space.

>> Assuming this can coexist with the existing usage, why not register this
>> as a gpio_chip with the gpiolib framework?
> 
> Ok, I will ?take a look at it.
> 
> 
>>
>>> Subject: [PATCH] i350: Add support for Intel i350 software defined pins
>>>
>>> +
>>> +/* Software defined pins 2-3 */
>>> +#define IGB_CTRL_EXT_SDP2_DATA E1000_CTRL_EXT_SDP2_DATA /* Value of SW Defineable Pin 2 */
>>> +#define IGB_CTRL_EXT_SDP3_DATA E1000_CTRL_EXT_SDP3_DATA /* Value of SW Defineable Pin 3 */
>>> +#define IGB_CTRL_EXT_SDP2_DIR ?E1000_CTRL_EXT_SDP2_DIR ?/* SDP2 Data direction */
>>> +#define IGB_CTRL_EXT_SDP3_DIR ?E1000_CTRL_EXT_SDP3_DIR ?/* SDP3 Data direction */
>>
>> Looks like e1000_defines.h already has this info.
>>
> 
> Only partially, so I decided to copy it to avoid situtation then I have in one code ?IGB_ and E1000_ ?defines.
> 
> It is not good?

I think it would be preferable to just add to e1000_defines.h where
they're all currently located rather than duplicating them.

-Steve
