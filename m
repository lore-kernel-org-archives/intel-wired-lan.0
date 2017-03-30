From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 30 Mar 2017 12:17:29 +0300
Subject: [Intel-wired-lan] [next-queue v6 PATCH 2/7] i40e: Introduce
 Port Representor netdevs and switchdev mode.
In-Reply-To: <1490833375-2788-3-git-send-email-sridhar.samudrala@intel.com>
References: <1490833375-2788-1-git-send-email-sridhar.samudrala@intel.com>
 <1490833375-2788-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <CAJ3xEMh6Un8JH3275nxOw25RtBp5KnYX+EMSv84+C_ezpkZGGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 30, 2017 at 3:22 AM, Sridhar Samudrala
<sridhar.samudrala@intel.com> wrote:
> Port Representator netdevs are created for each PF and VF if the switch
> mode is set to 'switchdev'. These netdevs can be used to control and
> configure VFs and PFs when they are moved to a different namespace.
> They enable exposing statistics, configure and monitor link state, mtu,
> filters,fdb/vlan entries etc.


What netdev represents the uplink (wire port) in your impl?
