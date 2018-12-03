From: Steve Douthit <stephend@silicom-usa.com>
Date: Mon, 3 Dec 2018 23:42:38 +0000
Subject: [Intel-wired-lan] [PATCH net-next v4 0/2] Add mii_bus to ixgbe
 driver for dsa devs
In-Reply-To: <19b22292-f2b3-ccb8-bb37-0952cfa93135@gmail.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203201432.18252-1-stephend@silicom-usa.com>
 <19b22292-f2b3-ccb8-bb37-0952cfa93135@gmail.com>
Message-ID: <5c8b517a-6632-931d-c695-ec8a5302bfa4@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Not directly related to this patch series, are you using the legacy or
> "new" way of passing platform data in order to register the DSA switch?
> Since you mentioned 6390, I would assume this must be the "new" way of
> registering DSA devices with mdio_boardinfo etc. In that case, have you
> found yourself limited by the current dsa_chip_platform_data?

With the new method I had an off-by-one error where the 'enabled_ports'
bitmask and 'port_names' array didn't match up in my first attempt.
That's definitely my fault, but the loop that searches for the "cpu"
string didn't like it and segfaulted.

I've got something of a chicken-and-the-egg problem between where I'm
deferring while waiting for netdevs to show up, and registering the
mdio_board_info that needs those same pointers.  For testing I exported
mdiobus_setup_mdiodev_from_board_info() and mdiobus_create_device() so I
could call the setup function again when the data was actually ready.

It'd be nice to have more than one "cpu" port on a switch and have some
way to associate downstream and "cpu" ports.  Not sure exactly what that
would look like, and it's not something I'm going to try and tackle at
the moment, but it's one for the wish list.
