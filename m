From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Mon, 3 Apr 2017 11:41:15 -0700
Subject: [Intel-wired-lan] [next-queue v6 PATCH 2/7] i40e: Introduce
 Port Representor netdevs and switchdev mode.
In-Reply-To: <CAJ3xEMgVeri17KceKhnFUCCFj00yWXKtjwP4r36Pb-CSZiOTng@mail.gmail.com>
References: <1490833375-2788-1-git-send-email-sridhar.samudrala@intel.com>
 <1490833375-2788-3-git-send-email-sridhar.samudrala@intel.com>
 <CAJ3xEMgVeri17KceKhnFUCCFj00yWXKtjwP4r36Pb-CSZiOTng@mail.gmail.com>
Message-ID: <58E2974B.30503@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 3/30/2017 12:17 AM, Or Gerlitz wrote:
> On Thu, Mar 30, 2017 at 3:22 AM, Sridhar Samudrala 
> <sridhar.samudrala at intel.com <mailto:sridhar.samudrala@intel.com>> wrote:
>
>     Port Representator netdevs are created for each PF and VF if the
>     switch
>     mode is set to 'switchdev'. These netdevs can be used to control and
>     configure VFs and PFs when they are moved to a different namespace.
>     They enable exposing statistics, configure and monitor link state,
>     mtu,
>     filters,fdb/vlan entries etc.
>
>
>
> What netdev represents the uplink (wire port) in your impl?
>
We don't have a port netdev representing the uplink in this 
implementation as we
cannot control the frames going out the uplink via sw rules with the 
current generation of
hw/fw.

-Sridhar

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170403/b8a82103/attachment.html>
