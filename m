From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 26 Mar 2018 20:29:34 +0000
Subject: [Intel-wired-lan] Patch for igb_main.c
In-Reply-To: <CAKgT0UcHZUs2aN_c1Nxe7iiEYAaZG200Lsmoi=JvgbW0YquAmw@mail.gmail.com>
References: <CAAMvbhES0YLfp__ErFxivfMHhpCrOq0z47a4w84JP547VBhd_Q@mail.gmail.com>
 <1522078775.2528.65.camel@intel.com>
 <CAAMvbhH97su8=-amyXch6fhiEwVr=Dofg9BZPWxSrJDHDgmytQ@mail.gmail.com>
 <CAKgT0UcHZUs2aN_c1Nxe7iiEYAaZG200Lsmoi=JvgbW0YquAmw@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD6984E956A@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Is this a board you designed? Why doesn't it have a properly programmed NVM?

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Alexander Duyck
Sent: Monday, March 26, 2018 1:10 PM
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: intel-wired-lan at osuosl.org
Subject: Re: [Intel-wired-lan] Patch for igb_main.c

On Mon, Mar 26, 2018 at 12:00 PM, James Courtier-Dutton <james.dutton@gmail.com> wrote:
>
>
> On Mon, 26 Mar 2018, 16:39 Duyck, Alexander H, 
> <alexander.h.duyck@intel.com>
> wrote:
>>
>>
>> Any idea why the MAC address is invalid? Does the part not have an 
>> NVM, or is the NVM not populated correctly?
>>
>> I'm really not a fan of us enabling a random MAC address for the 
>> device if a valid one is not present. I would like to know more about 
>> why a valid one is not present and see if we can address that before 
>> we start working around it in the driver.
>>
>> Thanks.
>>
>> - Alex
>
>
> Hi Alex,
>
> The intention is that it only chooses a random mac addres if all other 
> options are not available.
> It is better for the driver to load than not at all.
>
> Kind regards
>
> James

Hi James,

I disagree. If we have an NVM issue it is better for us to fail loading the driver than for us to load and just have random data populating the fields that are supposed to be configured by the NVM.
You changes impacts all devices supported by the driver. Not just the one system you care about. We need to take all of them into account.

I would much rather have a driver fail to load than open us up to the potential for things like a kernel panic.

Thanks.

- Alex
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
