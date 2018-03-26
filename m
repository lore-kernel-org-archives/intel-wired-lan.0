From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 26 Mar 2018 21:13:59 +0000
Subject: [Intel-wired-lan] Patch for igb_main.c
In-Reply-To: <CAAMvbhFxOC5QoHQhvLRrXSF9g6cfE+h10mEBYYHKDzFu19vV-A@mail.gmail.com>
References: <CAAMvbhES0YLfp__ErFxivfMHhpCrOq0z47a4w84JP547VBhd_Q@mail.gmail.com>
 <1522078775.2528.65.camel@intel.com>
 <CAAMvbhH97su8=-amyXch6fhiEwVr=Dofg9BZPWxSrJDHDgmytQ@mail.gmail.com>
 <CAKgT0UcHZUs2aN_c1Nxe7iiEYAaZG200Lsmoi=JvgbW0YquAmw@mail.gmail.com>
 <9B4A1B1917080E46B64F07F2989DADD6984E956A@ORSMSX110.amr.corp.intel.com>
 <CAAMvbhFxOC5QoHQhvLRrXSF9g6cfE+h10mEBYYHKDzFu19vV-A@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD6984E959C@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I think you need to contact the manufacturer if the NVM doesn?t have a MAC address programmed correctly.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: James Courtier-Dutton [mailto:james.dutton at gmail.com] 
Sent: Monday, March 26, 2018 1:43 PM
To: Fujinaka, Todd <todd.fujinaka@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>; intel-wired-lan at osuosl.org
Subject: Re: [Intel-wired-lan] Patch for igb_main.c

On 26 March 2018 at 21:29, Fujinaka, Todd <todd.fujinaka@intel.com> wrote:
> Is this a board you designed? Why doesn't it have a properly programmed NVM?
>
> Todd Fujinaka
> Software Application Engineer
> Datacenter Engineering Group
> Intel Corporation
> todd.fujinaka at intel.com
>

Hi,

No. I have not designed the board.

It is for this device:
http://www.compulab.co.il/utilite-computer/web/utilite-overview

The manufacturer of the device only has a very old kernel for the device.
I have some patches that can make it work with the latest Linux kernel.
See here:
https://github.com/jcdutton/linux-utilite/tree/v4.15.7-utilite

Of those patches, one of them is for the igb-main.c  file.

My aim is to get all the patches into mainline, at which point, I will not need to manage my own kernel for this device.
I only have 4 remaining patches to go, one of which is this igb-main.c one.

Kind Regards

James
