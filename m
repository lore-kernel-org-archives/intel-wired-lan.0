From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 30 Mar 2016 13:20:01 -0400
Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: Limit TSO to 7
 descriptors for payload instead of 8 per packet
In-Reply-To: <CAKgT0UdTgaeamyLetGPK0mqMNS-80BTc8t-WdSGJuuLDfz4JOg@mail.gmail.com>
References: <20160330064213.12927.46852.stgit@localhost.localdomain>
 <20160330170011.GB27540@oracle.com>
 <CAKgT0UdTgaeamyLetGPK0mqMNS-80BTc8t-WdSGJuuLDfz4JOg@mail.gmail.com>
Message-ID: <20160330172001.GD27540@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/30/16 10:12), Alexander Duyck wrote:
> Yeah.  The patch was sort of a knee-jerk reaction to being told that
> the patch referenced caused a regression.  From what I can tell that
> is not the case as I am also seeing the Tx hangs when I run the test
> with the frames being linearized.

I'm not sure how important of a subtlety this is, but the actual
console log after the patch is the following:

 i40e 0000:82:00.0: TX driver issue detected, PF reset issued
 i40e 0000:82:00.0 eth2: adding 68:05:ca:30:dd:18 vid=0
 i40e 0000:82:00.0: TX driver issue detected, PF reset issued
 i40e 0000:82:00.0 eth2: adding 68:05:ca:30:dd:18 vid=0
 i40e 0000:82:00.0: TX driver issue detected, PF reset issued

Comparing with what I'd pasted in the sourceforge thread earlier,
I see that it does not say "Hung Tx queue etc."  any more, though
it still resets.

Not sure if that changed info is significant?

--Sowmini


