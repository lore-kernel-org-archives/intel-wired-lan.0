From: James Courtier-Dutton <james.dutton@gmail.com>
Date: Mon, 26 Mar 2018 19:00:13 +0000
Subject: [Intel-wired-lan] Patch for igb_main.c
In-Reply-To: <1522078775.2528.65.camel@intel.com>
References: <CAAMvbhES0YLfp__ErFxivfMHhpCrOq0z47a4w84JP547VBhd_Q@mail.gmail.com>
 <1522078775.2528.65.camel@intel.com>
Message-ID: <CAAMvbhH97su8=-amyXch6fhiEwVr=Dofg9BZPWxSrJDHDgmytQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 26 Mar 2018, 16:39 Duyck, Alexander H, <alexander.h.duyck@intel.com>
wrote:

>
> Any idea why the MAC address is invalid? Does the part not have an NVM,
> or is the NVM not populated correctly?
>
> I'm really not a fan of us enabling a random MAC address for the device
> if a valid one is not present. I would like to know more about why a
> valid one is not present and see if we can address that before we start
> working around it in the driver.
>
> Thanks.
>
> - Alex


Hi Alex,

The intention is that it only chooses a random mac addres if all other
options are not available.
It is better for the driver to load than not at all.

Kind regards

James
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180326/f7a8ba7d/attachment.html>
