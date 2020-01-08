From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 8 Jan 2020 14:47:20 -0800
Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: Remove limit of 10
 entries for unicast filter list
In-Reply-To: <ff7c1cc5-3bec-3ce7-f584-6fb1ef1f9cbe@gmail.com>
References: <20191125142452.21819-1-radoslawx.tyl@intel.com>
 <7e9bbd9b-ee05-b207-a472-77d03c3ee6ac@molgen.mpg.de>
 <CAKgT0UexoZWiF7Z745O3FkA+A+f-E31DhD5mGXjweXecrRJtgw@mail.gmail.com>
 <ff7c1cc5-3bec-3ce7-f584-6fb1ef1f9cbe@gmail.com>
Message-ID: <35f3bcec-6685-d6c3-8842-09fc1729dd57@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/25/2019 11:14 AM, Gregory Rose wrote:
> 
> It's tough to recall exactly what my thinking was - 8 years is a long 
> time.? However, I think you're
> right that this is about resource sharing and not allowing any single VF 
> to consume all the remaining
> RAR entries.? Ten entries seems arbitrary but I do recall at the time a 
> common test setup was with
> 4 VFs.? Also, we needed to reserve RAR entries for the PF too IIRC.
> 
> Maybe Sibai can recall, I don't know if she's still at Intel but maybe 
> ask her as well.
> 
> Sorry I couldn't be more help.
> 
> Regards,
> 
> - Greg

Right. This is what I would have thought as well. By not limiting, we
potentially allow one VF to hog all of the resources.

It's plausible that this limit ought to be configurable instead of
static. This way, a system administrator could change the limit on the
PF and enable more entries than the static limit of 10.

That obviously requires more plumbing in place to represent the limit
and find an adequate way of informing the PF system administrator...

Thanks,
Jake
