From: Edward Cree <ecree@solarflare.com>
Date: Wed, 27 May 2015 18:04:27 +0100
Subject: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
In-Reply-To: <C5551D9AAB213A418B7FD5E4A6F30A07892FD632@ORSMSX108.amr.corp.intel.com>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05EB28F4@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FB5E4@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB3B4A@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FBBEC@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB4EE6@BPXM14GP.gisp.nec.co.jp>
 <C5551D9AAB213A418B7FD5E4A6F30A07892F9481@ORSMSX108.amr.corp.intel.com>
 <F6FB0E698C9B3143BDF729DF22286646912FC2E3@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB8A65@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FDC17@ORSMSX110.amr.corp.intel.com>
 <C5551D9AAB213A418B7FD5E4A6F30A07892FC8C7@ORSMSX108.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB9DA7@BPXM14GP.gisp.nec.co.jp>
 <5565887B.5010808@solarflare.com>
 <F6FB0E698C9B3143BDF729DF22286646912FE16E@ORSMSX110.amr.corp.intel.com>
 <C5551D9AAB213A418B7FD5E4A6F30A07892FD632@ORSMSX108.amr.corp.intel.com>
Message-ID: <5565F91B.8080405@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 27/05/15 16:55, Rose, Gregory V wrote:
> There's nothing to prevent any vendor from notifying a VF that it has privileges and there's nothing that require that they do.  This should be a vendor specific detail.
Agreed - purely a driver implementation detail.
> So now that I've stated my preference let me also state that I do not want to hold up acceptance of the Hiroshi's if_link patch that sets the trusted/privileged state for the VF while we further discuss this driver specific detail.
Agreed.
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
