From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 26 Mar 2018 14:23:18 -0700
Subject: [Intel-wired-lan] Patch for igb_main.c
In-Reply-To: <CAAMvbhFxOC5QoHQhvLRrXSF9g6cfE+h10mEBYYHKDzFu19vV-A@mail.gmail.com>
References: <CAAMvbhES0YLfp__ErFxivfMHhpCrOq0z47a4w84JP547VBhd_Q@mail.gmail.com>
 <1522078775.2528.65.camel@intel.com>
 <CAAMvbhH97su8=-amyXch6fhiEwVr=Dofg9BZPWxSrJDHDgmytQ@mail.gmail.com>
 <CAKgT0UcHZUs2aN_c1Nxe7iiEYAaZG200Lsmoi=JvgbW0YquAmw@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD6984E956A@ORSMSX110.amr.corp.intel.com>
 <CAAMvbhFxOC5QoHQhvLRrXSF9g6cfE+h10mEBYYHKDzFu19vV-A@mail.gmail.com>
Message-ID: <CAKgT0Uf6vwX6EUJa9TJ8DRQ=+E_e-y6av5X=oS2RvJDt66Nosg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 26, 2018 at 1:42 PM, James Courtier-Dutton
<james.dutton@gmail.com> wrote:
> On 26 March 2018 at 21:29, Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
>> Is this a board you designed? Why doesn't it have a properly programmed NVM?
>>
>> Todd Fujinaka
>> Software Application Engineer
>> Datacenter Engineering Group
>> Intel Corporation
>> todd.fujinaka at intel.com
>>
>
> Hi,
>
> No. I have not designed the board.
>
> It is for this device:
> http://www.compulab.co.il/utilite-computer/web/utilite-overview
>
> The manufacturer of the device only has a very old kernel for the device.
> I have some patches that can make it work with the latest Linux kernel.
> See here:
> https://github.com/jcdutton/linux-utilite/tree/v4.15.7-utilite
>
> Of those patches, one of them is for the igb-main.c  file.

Have you done any work to root cause why the MAC address is invalid?
For example is it all 0's or by chance is it all 1's?

I ask because there appears to be a known method for addressing an
issue of getting the MAC address configured for these parts via
u-boot:
http://www.compulab.co.il/utilite-computer/forum/viewtopic.php?f=66&t=1986

> My aim is to get all the patches into mainline, at which point, I will
> not need to manage my own kernel for this device.
> I only have 4 remaining patches to go, one of which is this igb-main.c one.
>
> Kind Regards
>
> James

I'm not sure this needs patch needs to be committed. If I am
understanding things correctly this can just be setup correctly in
u-boot and the problem is solved. We already have code in the igb
driver to handle platform provided MAC addresses and it seems like
this is how this is supposed to be configured.

Thanks.

- Alex
