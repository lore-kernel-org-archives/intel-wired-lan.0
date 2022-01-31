From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 31 Jan 2022 10:40:38 -0800
Subject: [Intel-wired-lan] [PATCH net-next] net: kbuild: Don't default
 net vendor configs to y
In-Reply-To: <20220131183540.6ekn3z7tudy5ocdl@sx1>
References: <20220131172450.4905-1-saeed@kernel.org>
 <20220131095905.08722670@hermes.local>
 <CAMuHMdU17cBzivFm9q-VwF9EG5MX75Qct=is=F2h+Kc+VddZ4g@mail.gmail.com>
 <20220131183540.6ekn3z7tudy5ocdl@sx1>
Message-ID: <30ed8220-e24d-4b40-c7a6-4b09c84f9a1f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 1/31/2022 10:35 AM, Saeed Mahameed wrote:
> On 31 Jan 19:30, Geert Uytterhoeven wrote:
>> On Mon, Jan 31, 2022 at 6:59 PM Stephen Hemminger
>> <stephen@networkplumber.org> wrote:
>>> On Mon, 31 Jan 2022 09:24:50 -0800
>>> Saeed Mahameed <saeed@kernel.org> wrote:
>>>
>>> > From: Saeed Mahameed <saeedm@nvidia.com>
>>> >
>>> > NET_VENDOR_XYZ were defaulted to 'y' for no technical reason.
>>> >
>>> > Since all drivers belonging to a vendor are supposed to default to 
>>> 'n',
>>> > defaulting all vendors to 'n' shouldn't be an issue, and aligns well
>>> > with the 'no new drivers' by default mentality.
>>> >
>>> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>>>
>>> This was done back when vendors were introduced in the network 
>>> drivers tree.
>>> The default of Y allowed older configurations to just work.
>>
>> And changing the defaults means all defconfigs must be updated first,
>> else the user's configs will end up without drivers needed.
>>
> 
> As I understand correctly, at least for most common net drivers, having 
> NET_VENDOR_XYZ=y doesn't actually build anything, we have flags per
> module for each vendor and those are defaulted to N.

Right, but once you start hiding NET_VENDOR_DRIVER_XYZ under a 
NET_VENDOR_XYZ Kconfig symbol dependency, if NET_VENDOR_XYZ is not set 
to Y, then you have no way to select NET_VENDOR_DRIVER_XYZ and so your 
old defconfig breaks.

> 
>>> So there was a reason, not sure if it matters anymore.
>>> But it seems like useless repainting to change it now.
>>
>> It might make sense to tune some of the defaults (i.e. change to
>> "default y if ARCH_*") for drivers with clear platform dependencies.
>>
> 
> either set hard default to 'n' or just keep it as is, anything else is just
> more confusion.

Maybe the rule should go like this: any new driver vendor defaults to n, 
and existing ones remain set to y, until we deprecate doing that and 
switching them all off to n by 5.18?
-- 
Florian
