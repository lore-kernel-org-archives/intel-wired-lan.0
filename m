From: Steve Douthit <stephend@silicom-usa.com>
Date: Tue, 4 Dec 2018 16:02:20 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 0/2] Add mii_bus to ixgbe
 driver for dsa devs
In-Reply-To: <c8e3976f-73f9-80be-f6d6-c9a1f064a096@gmail.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203201432.18252-1-stephend@silicom-usa.com>
 <19b22292-f2b3-ccb8-bb37-0952cfa93135@gmail.com>
 <5c8b517a-6632-931d-c695-ec8a5302bfa4@silicom-usa.com>
 <c8e3976f-73f9-80be-f6d6-c9a1f064a096@gmail.com>
Message-ID: <f356be57-cae3-9ba7-6232-dc21a3e778ee@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/3/18 6:46 PM, Florian Fainelli wrote:
> Yes, we have been discussing that topic with Andrew and have a few ideas
> on how that could be achieved, but not code to use that at the moment.
> One of the idea was to finally allow enslaving the DSA master network
> device, that way you could assign specific ports to a specific CPU/DSA
> master network port within the switch, though that requires setting up a
> bridge. Would that work for your use case?

If bridge here means a port based vlan, then yes that works.  If we're
talking about something that shows up under brctl, then that's less
ideal.

It's probably time to split the thread for any further discussion since
this isn't really relevant to intel-wired-lan anymore.
