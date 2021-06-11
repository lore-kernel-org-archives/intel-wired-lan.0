From: Kurt Kanzenbach <kurt@linutronix.de>
Date: Fri, 11 Jun 2021 13:01:29 +0200
Subject: [Intel-wired-lan] [PATCH next-queue v1 5/5] igc: Export LEDs
In-Reply-To: <37283593-408d-cdfd-ed5c-f2c215af87d8@molgen.mpg.de>
References: <20210611003924.492853-1-vinicius.gomes@intel.com>
 <20210611003924.492853-6-vinicius.gomes@intel.com>
 <37283593-408d-cdfd-ed5c-f2c215af87d8@molgen.mpg.de>
Message-ID: <87lf7gmzqu.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri Jun 11 2021, Paul Menzel wrote:
> Dear Vinicius, dear Kurt,
>
>
> Am 11.06.21 um 02:39 schrieb Vinicius Costa Gomes:
>> From: Kurt Kanzenbach <kurt@linutronix.de>
>> 
>> Each i225 has three LEDs. Export them via the LED class framework.
>
> Very nice. For those not familiar with the LED class framework, could 
> you add one example how to control one of the LEDs?
>
> Also it?d be nice to document, how this was tested.

Each LED is controllable via sysfs. Example:

 $ cd /sys/class/leds/igc_led0
 $ cat brightness      # Current Mode
 $ cat max_brightness  # 15
 $ echo 0 > brightness # Mode 0
 $ echo 1 > brightness # Mode 1

The brightness field here reflects the different LED modes ranging from
0 to 15.

Thanks,
Kurt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 861 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210611/62502b6e/attachment.asc>
