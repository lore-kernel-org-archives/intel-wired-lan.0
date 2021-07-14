From: Ruinskiy, Dima <dima.ruinskiy@intel.com>
Date: Wed, 14 Jul 2021 12:05:51 +0300
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Make mei_me active when
 e1000e is in use
In-Reply-To: <CAAd53p79BwxPGRECYGrpCQbSJz8NY2WrG+AJCuaj89XNqCy59Q@mail.gmail.com>
References: <20210712133500.1126371-1-kai.heng.feng@canonical.com>
 <20210712133500.1126371-2-kai.heng.feng@canonical.com>
 <3947d70a-58d0-df93-24f1-1899fd567534@intel.com>
 <CAAd53p79BwxPGRECYGrpCQbSJz8NY2WrG+AJCuaj89XNqCy59Q@mail.gmail.com>
Message-ID: <16e188d5-f06e-23dc-2f71-c935240dd3b4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 14/07/2021 9:28, Kai-Heng Feng wrote:
>> I do not know how MEI driver affect 1Gbe driver - so, I would suggest to
>> involve our CSME engineer (alexander.usyskin at intel.com) and try to
>> investigate this problem.
>> Does this problem observed on Dell systems? As I heard no reproduction
>> on Intel's RVP platform.
>> Another question: does disable mei_me runpm solve your problem?
> 
> Yes, disabling runpm on mei_me can workaround the issue, and that's
> essentially what this patch does by adding DL_FLAG_PM_RUNTIME |
> DL_FLAG_RPM_ACTIVE flag.
> 
> Kai-Heng
Hi, Kai-Heng,

If the goal of the patch is to essentially disable runpm on mei_me, then 
why is the patch touching code in the e1000e driver?

I agree with Sasha Neftin; it seems like the wrong location, and the 
wrong way to do it, even if it currently works. We need to understand 
what causes runpm of mei_me to adversely affect LAN Rx, and for this we 
need the involvement of mei_me owners.

--Dima
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
