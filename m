From: Jesse Gross <jesse@nicira.com>
Date: Mon, 24 Aug 2015 17:14:31 -0700
Subject: [Intel-wired-lan] [RFC v1 2/4] geneve: Add geneve udp port
 offload for ethernet devices
In-Reply-To: <C40BE8378EF49C44B9184714DBC8EF2992F00BDA@ORSMSX110.amr.corp.intel.com>
References: <1440453891-214878-1-git-send-email-anjali.singhai@intel.com>
 <1440453891-214878-2-git-send-email-anjali.singhai@intel.com>
 <CAEP_g=-SvqUaaw7BeaTLmkOa=r4_NLy=yzguXSZb6AfecB_fCw@mail.gmail.com>
 <C40BE8378EF49C44B9184714DBC8EF2992F00BDA@ORSMSX110.amr.corp.intel.com>
Message-ID: <CAEP_g=9umhav1SEBc9j2jwkzjy8zDWGWKaQ8xw1AsvGDY31pfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks!

On Mon, Aug 24, 2015 at 4:03 PM, Singhai, Anjali
<anjali.singhai@intel.com> wrote:
> Sorry my bad. I meant to send the patch series to Netdev for further review feedback as you had suggested in the mean while but ended up resending here.
> V2 of the patches are on the way with your feedback.
>
> Thanks
> Anjali
>
>> -----Original Message-----
>> From: Jesse Gross [mailto:jesse at nicira.com]
>> Sent: Monday, August 24, 2015 4:00 PM
>> To: Singhai, Anjali
>> Cc: intel-wired-lan
>> Subject: Re: [Intel-wired-lan] [RFC v1 2/4] geneve: Add geneve udp port
>> offload for ethernet devices
>>
>> On Mon, Aug 24, 2015 at 3:04 PM, Anjali Singhai Jain
>> <anjali.singhai@intel.com> wrote:
>> > Add ndo_ops to add/del UDP ports to a device that supports geneve
>> > offload.
>> >
>> > v2:Added comments for new ndo_ops and minor format fix.
>> >
>> > Signed-off-by: Kiran Patil <kiran.patil@intel.com>
>> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
>>
>> I'm a little confused - what happened to the comments on this patch and
>> patch 4?
