From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 5 Jan 2017 14:08:54 +0200
Subject: [Intel-wired-lan] [net-next PATCH v2 5/6] i40e: Add TX and RX
	support in switchdev mode.
In-Reply-To: <1483466874-2962-6-git-send-email-sridhar.samudrala@intel.com>
References: <1483466874-2962-1-git-send-email-sridhar.samudrala@intel.com>
 <1483466874-2962-6-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <CAJ3xEMiSt2a9rQYpjtu=o8YBA2YjPD=6nSwBnh5gfuseQwXCcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 3, 2017 at 8:07 PM, Sridhar Samudrala
<sridhar.samudrala@intel.com> wrote:
> A host based switching entity like a linux bridge or OVS redirects these frames
> to the right VFs via VFPR netdevs. Any frames sent via VFPR netdevs are sent as
> directed transmits to the corresponding VFs. To enable directed transmit, skb
> metadata dst is used to pass the VF id and the frame is requeued to call the PFs
> transmit routine.

Jakub/John, patch #4 which didn't appear in the list had a long discussion [1]
ending  with "lets talk on it @ netdev", did we?

Or.

[1] http://marc.info/?t=147457252900002&r=1&w=2
