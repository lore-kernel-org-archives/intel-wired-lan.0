From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 7 Feb 2018 09:22:25 -0800
Subject: [Intel-wired-lan] intel: add SPDX identifiers to all the Intel
 drivers
In-Reply-To: <affca359-c7e0-79f9-4c55-d1f76245887f@oracle.com>
References: <20180202231131.9990-1-jeffrey.t.kirsher@intel.com>
 <affca359-c7e0-79f9-4c55-d1f76245887f@oracle.com>
Message-ID: <f7d70453-a39f-61b8-766c-a5ec34bbf900@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2/7/2018 9:13 AM, Shannon Nelson wrote:
> On 2/2/2018 3:11 PM, Jeff Kirsher wrote:
>> Add the SPDX identifiers to all the Intel wired LAN driver files, as
>> outlined in Documentation/process/license-rules.rst.
> 
> It was just pointed out to me on netdev that the SPDX tag "GPL-2.0" has 
> been deprecated.? See the bottom of https://spdx.org/licenses/ for details.
> 
> Of course GregKH and friends have put this tag all over the kernel 
> already, so I don't know what they're going to do.? However, using 
> "GPL-2.0-only" might make more sense for your files.
> 
> In several of the Sun files I was attempting to patch we have the text
>  ?* published by the Free Software Foundation; either version 2 of the
>  ?* License, or (at your option) any later version.
> so I'll likely need to use "GPL-2.0+".

s/GPL-2.0+/GPL-2.0-or-later/

> 
> sln
